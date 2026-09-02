# Mobile Dev on Claude Code

> **한눈에 / At a glance**
>
> A practical guide for continuing Claude Code development across a smartphone, SSH, tmux, and multiple machines.
>
> 한영 프로젝트 설명, 검색 키워드, 저작권 범위: [PROJECT.md](./PROJECT.md) · [NOTICE.md](./NOTICE.md) · [PUBLICATION_REVIEW.md](./PUBLICATION_REVIEW.md)


> 스마트폰과 여러 Mac을 오가며 Claude Code로 개발을 이어가는 실전 가이드.
> 개인 경험 기록 + 교육자료로 발전시키는 워크스페이스.

## 누구를 위한 가이드인가

- **여러 대의 Mac**을 쓰면서 개발 환경을 통일하고 싶은 사람
- **스마트폰에서 SSH**로 개발을 이어받고 싶은 사람
- **Claude Code + tmux**로 SSH 끊김에도 안전한 워크플로우를 원하는 사람
- cmux/Tailscale을 사용해서 멀티머신 개발 환경을 운영하는 사람

## 관련 레포

- [nori00000/claude-code-setup](https://github.com/nori00000/claude-code-setup) — 실제 셋업 스크립트
- [nori00000/codex-setup](https://github.com/nori00000/codex-setup) — 자매 프로젝트 (codex 버전) <!-- DOC-SYNC: 재검증 완료 (2026-07-07) — GitHub API로 nori00000/codex-setup 공개 레포 존재 재확인(private: false). 단, 로컬 ~/codex-setup의 git remote는 별도 비공개 미러(codex-setup-private.git)를 가리키므로 로컬 작업 시 주의 -->

## 목차

| 노트 | 내용 |
|------|------|
| [00. 인덱스](00.%20%F0%9F%8F%9B%20Claude%20Code%20%EB%AA%A8%EB%B0%94%EC%9D%BC%20%EA%B0%9C%EB%B0%9C%20%EC%9D%B8%EB%8D%B1%EC%8A%A4.md) | 전체 허브 노트 |
| [01. 핵심 개념](01.%20%ED%95%B5%EC%8B%AC%20%EA%B0%9C%EB%85%90%20%E2%80%94%20tmux%2C%20cl%2C%20clp.md) | tmux, cl, clp, clr, clf, cli 쉬운 설명 |
| [02. 5단계 운영 플로우](02.%205%EB%8B%A8%EA%B3%84%20%EC%9A%B4%EC%98%81%20%ED%94%8C%EB%A1%9C%EC%9A%B0.md) | 시나리오별 사용법 |
| [03. Termux 안드로이드 설정](03.%20Termux%20%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C%20%EC%84%A4%EC%A0%95.md) | Android 실전 설치 가이드 |
| [04. 내 경험 기록](04.%20%EB%82%B4%20%EA%B2%BD%ED%97%98%20%EA%B8%B0%EB%A1%9D.md) | 실제 사용 로그 |
| [05. 트러블슈팅 노트](05.%20%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85%20%EB%85%B8%ED%8A%B8.md) | 시간순 문제/해결 |
| [devlog/sessions/](devlog/sessions/) | 세션별 작업 로그 |

## 빠른 시작

```bash
# 평소 작업 시작
cl "작업 내용"

# 다른 Mac에서 이어받기
cd <프로젝트>
~/claude-code-setup/scripts/sync-current-branch.sh
cl "작업"

# 스마트폰에서 긴급 수정
ssh your-main-mac
cd <프로젝트>
~/claude-code-setup/scripts/check-cmux-health.sh
~/claude-code-setup/scripts/sync-current-branch.sh
cl "긴급 수정"

# cmux 불가 시 fallback
CL_NO_TMUX=1 cl "작업"
```

## 유틸리티 스크립트

| 스크립트 | 기능 |
|----------|------|
| `scripts/sync-from-obsidian.sh` | Obsidian 볼트 → 이 레포 동기화 (변경 감지 + 커밋 + 푸시) |

```bash
# Obsidian에서 노트 수정 후 레포에 반영
./scripts/sync-from-obsidian.sh

# 변경 사항만 확인 (커밋 없음)
./scripts/sync-from-obsidian.sh --dry-run

# 커밋까지만 (push 안 함)
./scripts/sync-from-obsidian.sh --no-push

# 커스텀 커밋 메시지
./scripts/sync-from-obsidian.sh --message "docs: 트러블슈팅 노트 추가"

# 도움말
./scripts/sync-from-obsidian.sh --help
```

> `OBSIDIAN_VAULT` 기본값: `~/Documents/your-obsidian-vault` (볼트 루트만 지정)
> 소스 디렉토리: `${OBSIDIAN_VAULT}/75. Projects/Claude Code 모바일 개발` (스크립트 내 하드코딩)
> 커스텀 볼트 루트: `OBSIDIAN_VAULT=~/다른볼트 ./scripts/sync-from-obsidian.sh`
> ⚠️ 머신마다 볼트 위치가 다를 수 있음. 볼트가 없는 머신에서는 반드시 `OBSIDIAN_VAULT` 지정.
> 🚨 **실행 전 필독**: `--dry-run`으로 실측한 결과(2026-07-14), Obsidian 원본 노트에는 실제 호스트명/사용자명(예: 실제 머신 이름, 실제 계정명)이 그대로 남아 있고, 이 레포의 `00.`~`05.` 노트는 공개 전환(2026-07-08) 과정에서 `your-main-mac`/`your-username` 등으로 수동 익명화된 상태입니다. 볼트 쪽 익명화가 아직 반영되지 않았기 때문에, `--dry-run` 없이 바로 동기화하면 개인 식별 정보가 공개 레포에 재유입될 수 있습니다. 실행 전 반드시 `--dry-run`으로 diff를 확인하고, 필요하면 볼트 원본을 먼저 익명화하세요.

## 워크스페이스의 진화

이 레포는 3단계로 진화합니다:

1. **[현재] 경험 수집** — Obsidian 볼트 + 이 레포에서 활성 기록
2. **개념 성숙** — Obsidian `30. Permanent Notes/`로 이주
3. **교육 자료화** — 강의/워크숍용으로 다듬은 최종 버전

## 라이선스

소스 코드는 [LICENSE](./LICENSE)(MIT), 문서는 별도 표기가 없는 한 CC BY 4.0 기준으로 제공됩니다.
저작권 범위와 재사용 조건은 [NOTICE.md](./NOTICE.md)를 참고하세요. <!-- DOC-SYNC: 2026-07-13 갱신 — 기존 "개인 학습/경험 기록용. 자유롭게 참고하세요."는 이 레포가 public 전환되며 NOTICE.md/PROJECT.md/LICENSE에 MIT+CC BY 4.0으로 라이선스가 공식화(2026-07-08)된 뒤에도 갱신되지 않은 stale 문구였음. gh api 재확인(2026-07-13): private:false, visibility:public -->

---

**Source of truth**: Obsidian 볼트의 `75. Projects/Claude Code 모바일 개발/`
**GitHub 레포**: 공개 버전 (마크다운 파일 동기화)
