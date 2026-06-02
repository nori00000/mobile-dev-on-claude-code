#!/usr/bin/env bash
set -euo pipefail

# sync-from-obsidian.sh
# Obsidian 볼트의 "75. Projects/Claude Code 모바일 개발/" 노트를
# 이 GitHub 레포로 동기화한다.
#
# 사용법:
#   ./scripts/sync-from-obsidian.sh                    # 기본: 변경 감지 + 커밋 + 푸시
#   ./scripts/sync-from-obsidian.sh --dry-run          # 변경만 확인 (커밋 안 함)
#   ./scripts/sync-from-obsidian.sh --no-push          # 커밋까지만
#   ./scripts/sync-from-obsidian.sh --message "메시지"  # 커스텀 커밋 메시지
#
# 환경변수:
#   OBSIDIAN_VAULT  커스텀 볼트 경로 (기본: ~/Documents/your-obsidian-vault)

VAULT_DEFAULT="${HOME}/Documents/your-obsidian-vault"
VAULT="${OBSIDIAN_VAULT:-${VAULT_DEFAULT}}"
SOURCE_DIR="${VAULT}/75. Projects/Claude Code 모바일 개발"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

DRY_RUN=false
NO_PUSH=false
CUSTOM_MESSAGE=""

usage() {
  sed -n 's/^# \{0,1\}//;3,15p' "$0"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --no-push) NO_PUSH=true; shift ;;
    --message) CUSTOM_MESSAGE="${2:-}"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown arg: $1" >&2; usage ;;
  esac
done

# 1. 소스 존재 확인
if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Error: Obsidian source dir not found: ${SOURCE_DIR}" >&2
  echo "Hint: set OBSIDIAN_VAULT env var if your vault is elsewhere." >&2
  exit 1
fi

echo "== Sync Source =="
echo "  ${SOURCE_DIR}"
echo ""
echo "== Sync Target =="
echo "  ${REPO_ROOT}"
echo ""

# 2. 소스 파일 개수 먼저 확인
source_count=0
for f in "${SOURCE_DIR}"/*.md; do
  [[ -f "$f" ]] || continue
  source_count=$((source_count + 1))
done

if [[ "${source_count}" -eq 0 ]]; then
  echo "No source .md files found in: ${SOURCE_DIR}" >&2
  exit 1
fi

# 3. 파일 복사 또는 변경 감지 (README.md, .gitignore, scripts/ 는 건드리지 않음)
changed=0
for f in "${SOURCE_DIR}"/*.md; do
  [[ -f "$f" ]] || continue
  base="$(basename "$f")"
  if [[ "${DRY_RUN}" == true ]]; then
    if [[ ! -f "${REPO_ROOT}/${base}" ]] || ! cmp -s "$f" "${REPO_ROOT}/${base}"; then
      echo "  [dry-run] update: ${base}"
      changed=$((changed + 1))
    fi
  else
    if [[ ! -f "${REPO_ROOT}/${base}" ]] || ! cmp -s "$f" "${REPO_ROOT}/${base}"; then
      cp "$f" "${REPO_ROOT}/${base}"
      changed=$((changed + 1))
    fi
  fi
done

# 4. Dry-run이면 여기서 종료
if [[ "${DRY_RUN}" == true ]]; then
  echo ""
  if [[ "${changed}" -eq 0 ]]; then
    echo "Dry-run: no changes. ${source_count} source files already in sync."
  else
    echo "Dry-run: ${changed} of ${source_count} files would be updated."
  fi
  exit 0
fi

# 4. Git 상태 확인
cd "${REPO_ROOT}"
if [[ -z "$(git status --porcelain 2>/dev/null)" ]]; then
  echo ""
  echo "No changes to commit. Already in sync."
  exit 0
fi

# 5. 변경 사항 표시
echo ""
echo "== Changes =="
git status --short
echo ""

# 6. 커밋
MESSAGE="${CUSTOM_MESSAGE:-sync from obsidian: $(date -u +%Y-%m-%dT%H:%MZ)}"
git add -A
git commit -m "${MESSAGE}" --quiet
echo "Committed: ${MESSAGE}"

# 7. 푸시
if [[ "${NO_PUSH}" == true ]]; then
  echo "Skipping push (--no-push)."
  exit 0
fi

git push origin "$(git branch --show-current)" --quiet
echo "Pushed to origin."
