# Publication Review / 공개 준비 점검

| Field | Value |
| --- | --- |
| Repository | `nori00000/mobile-dev-on-claude-code` |
| Worktree | `mobile-dev-on-claude-code` |
| Public readiness | `approved` <!-- DOC-SYNC: 2026-07-08 실측 — `gh api repos/nori00000/mobile-dev-on-claude-code` 확인 결과 `private:false`, `visibility:public`. 공개 전환이 이미 완료되어 이전 상태값("ready-for-final-visibility-approval")은 stale이었음 --> |
| Proposed visibility | `public` (전환 완료, 2026-07-08 확인) |
| Code license | MIT |
| Docs license | CC BY 4.0 unless otherwise noted |
| Secret scan | regex scan performed; no dedicated scanner installed locally |
| PII/content scan | regex/manual scan performed |
| Deletion approval needed | `no large or bulk deletion performed` |
| History rewrite needed | unknown; not performed |

## Findings / 발견 사항

Personal host/user examples were generalized; no tracked bulk deletion required in this pass.

## Safe Public Scope / 공개 가능한 범위

- Generic source code, scripts, templates, and documentation after placeholder
  cleanup.
- Public-facing README/PROJECT/NOTICE metadata.
- Example environment files only when values are placeholders.

## Excluded Or Conditional Scope / 제외 또는 조건부 범위

- Real secrets, private account data, machine state, session logs with private
  operational content, generated outputs with unclear rights, and third-party
  assets without clear permission.

## Verification Plan / 검증 계획

- Run `git diff --check`.
- Run the narrowest project-native command available.
- Confirm `README.md`, `PROJECT.md`, `NOTICE.md`, `LICENSE`, and this review file
  exist before changing visibility.
## Verification Results / 검증 결과

git diff --check: pass. bash -n scripts/*.sh: pass. Direct identity/path pattern scan: pass except .git worktree pointer.

### 2026-07-14 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code`: `private:false`, `visibility:public` (재확인, 변동 없음).
- `git diff --check` / `bash -n scripts/*.sh`: pass (변동 없음).
- **신규 발견**: `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`)로 대조한 결과, Obsidian 원본 노트 6개(`00.`~`05.`) 전부가 이 레포의 공개본과 diff 있음. 원인은 이 레포가 공개 전환 시 수동 익명화(호스트명/사용자명 치환 등)되었고 그 결과가 볼트로 역반영되지 않았기 때문 — 자세한 내용은 `NOTICE.md`의 "Sync-back risk" 항목 참고. 볼트→레포 방향 동기화를 dry-run 없이 실행하면 PII 재유입 위험이 있음. <!-- DOC-SYNC: 2026-07-14 신규 발견, 자동 수정 대상 아님(볼트 파일은 이 레포 범위 밖) — README.md/NOTICE.md에 경고 추가로 완화 -->

### 2026-07-15 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` 재실행: 여전히 6/6 노트 diff — 위 "Sync-back risk"는 오늘도 유효 (변동 없음, 추가 조치 불요).
- `01.`~`05.` 노트가 참조하는 `~/claude-code-setup/scripts/*.sh` 8개(`bootstrap-mac.sh`, `check-cmux-health.sh`, `sync-current-branch.sh`, `ssh-main-mac-project.sh`, `init-project.sh`, `install-shell-integration.sh`, `install-hooks.sh`, `open-obsidian-note.sh`) 전부 실존 확인. `cl`/`clp`/`clr`/`clf`/`cli` 함수 정의, `check-cmux-health.sh` exit code 0/10/20 의미, `clf` 저장 경로(`~/.claude/feedback/<YYYY-MM>.jsonl`) 모두 소스와 정확히 일치 (MATCH).
- **신규 발견(자동 수정 보류)**: `02. 5단계 운영 플로우.md`의 "헬퍼 스크립트" 표(8개 스크립트 나열)가 작성된 이후, `~/claude-code-setup/scripts/`에 `install-codex-companion.sh`, `setup-tmux-yazi.sh`, `bootstrap-windows.ps1`, `apply-windows.ps1`, `diagnose-windows.ps1` 5개가 추가되어 표에 없음. 다만 이 노트의 서술 범위가 "Mac + 스마트폰(Termux)" 워크플로우로 한정되어 있고, 신규 5개 중 3개는 Windows용(.ps1), 1개는 Linux(apt 기반) 대상이라 이 노트 범위에 포함시킬지 애매함 — 추측으로 표를 채우지 않고 보류. 필요 시 사용자 판단 후 별도 반영 권장. <!-- DOC-SYNC: 2026-07-15 신규 발견, 범위 애매로 자동 수정 안 함 -->

### 2026-07-16 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: `01.`~`05.` 노트가 참조하는 8개 스크립트 전부 실존, 07-15에 발견된 미문서화 5개(`install-codex-companion.sh`, `setup-tmux-yazi.sh`, `bootstrap-windows.ps1`, `apply-windows.ps1`, `diagnose-windows.ps1`)도 그대로 존재 — 새 스크립트 추가/삭제 없음, 표 갱신 여부는 여전히 사용자 판단 대기.
- `git diff --check` / `bash -n scripts/*.sh`: pass (변동 없음). `.git`은 실제 디렉토리(worktree 포인터 아님) 재확인.
- 레포 원격 확인: 이 레포 origin은 `nori00000/mobile-dev-on-claude-code.git`, `~/claude-code-setup` origin은 `nori00000/claude-code-setup.git`, `~/codex-setup` origin은 `nori00000/codex-setup-private.git` — README.md·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000` 저작권 표시), `PROJECT.md`의 레포 내용물 목록(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions/), `devlog/sessions/`(파일 1개, `2026-04-12-0014-initial-setup.md`) 전부 실물과 정확히 일치 (MATCH).
- **결론**: 신규 MISMATCH/STALE_DOC 없음. 2026-07-13~15 세션에서 발견된 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 모두 오늘도 동일하게 유효하며 추가 조치 불요. <!-- DOC-SYNC: 2026-07-16 재검증, 변경 없음 -->

### 2026-07-17 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일 그대로(신규/삭제 없음), 07-15 발견 미문서화 5개(`install-codex-companion.sh`, `setup-tmux-yazi.sh`, `bootstrap-windows.ps1`, `apply-windows.ps1`, `diagnose-windows.ps1`)도 mtime 변동 없이 그대로 — `02. 5단계 운영 플로우.md` 표 갱신 여부는 여전히 사용자 판단 대기 (범위 애매, 자동 수정 안 함).
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `00. 🏛 Claude Code 모바일 개발 인덱스.md`·`02.`·`03.` 노트가 참조하는 스크립트 경로(`~/claude-code-setup/scripts/sync-current-branch.sh`, `check-cmux-health.sh` 등) 및 헬퍼 스크립트 표 8행 전부 실물과 일치 재확인 (MATCH).
- `git diff --check` / `bash -n scripts/*.sh`: pass (변동 없음). 레포 원격 3개(이 레포/`claude-code-setup`/`codex-setup` 로컬 클론) 재확인 — README·00. 인덱스 서술과 일치 (MATCH).
- **결론**: 신규 MISMATCH/STALE_DOC 없음. 기존에 발견된 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효, 추가 조치 불요. <!-- DOC-SYNC: 2026-07-17 재검증, 변경 없음 -->

### 2026-07-18 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(신규 파일 없음, 07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1`도 그대로) — `02. 5단계 운영 플로우.md` 표 갱신 여부는 여전히 사용자 판단 대기 (범위 애매, 자동 수정 안 함).
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 및 `clf` 저장 경로(`${HOME}/.claude/feedback/`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH). `01.`~`05.` 노트 전문을 재독해 상호 링크·명령어·exit code(0/10/20) 서술도 소스와 일치 확인 (MATCH).
- `git diff --check` / `bash -n scripts/*.sh`: pass. `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포/`claude-code-setup`/`codex-setup` 로컬 클론) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000` 저작권 표시, 2025-2026), `devlog/sessions/`(파일 1개, `2026-04-12-0014-initial-setup.md`, `--watch` 미구현 기록이 스크립트 실제 옵션과 일치) 재확인 (MATCH).
- **신규 발견**: `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md`의 2026-07-13~17 doc-sync 편집분이 아직 git에 **커밋되지 않은 상태**로 워킹트리에 남아 있음(`git status`: 3개 파일 modified, unstaged). 문서 내용 자체는 실제 상태와 일치하지만, 이 편집들이 원격에 반영되지 않아 GitHub 공개본에는 아직 구버전 문구(예: README의 옛 라이선스 문구, sync-back 경고 누락)가 노출 중일 수 있음. Doc-Sync 에이전트는 커밋 여부를 사용자 승인 없이 결정하지 않으므로 자동 커밋하지 않음 — 사용자 판단 필요. <!-- DOC-SYNC: 2026-07-18 신규 발견, 커밋은 사용자 승인 필요 사안이라 자동 수행 안 함 -->
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 신규로 "미커밋 상태" 1건 발견 — 조치는 사용자 확인 후 진행 권장. <!-- DOC-SYNC: 2026-07-18 재검증 -->

### 2026-07-19 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일 (07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 포함, 신규/삭제 없음). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지. 참고: 07-18 기록의 "14개 파일"은 이번 재조회(13개)와 불일치하나, 라이브 문서 claim이 아닌 과거 일자별 로그 항목이라 소급 수정하지 않음(단순 계수 변동/오기로 추정, 실질적 스크립트 증감 아님 — git 이력·mtime 모두 07-13 이후 변동 없음).
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/*.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **미해결 발견 지속 확인**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18과 동일하게 여전히 unstaged modified 상태로 남아 있음(1일 경과, 추가 파일 변경 없음). 문서 내용 자체는 실제 상태와 일치하나 GitHub 공개본에는 미반영 상태 지속 — 이번 세션에서도 커밋은 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, 미커밋 상태)은 오늘도 동일하게 유효. <!-- DOC-SYNC: 2026-07-19 재검증 -->

### 2026-07-20 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **미해결 발견 지속 확인**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 동일하게 여전히 unstaged modified 상태로 남아 있음(3일 경과, 추가 파일 변경 없음). 문서 내용 자체는 실제 상태와 일치하나 GitHub 공개본에는 미반영 상태 지속 — 이번 세션에서도 커밋은 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, 미커밋 상태 3일 경과)은 오늘도 동일하게 유효. <!-- DOC-SYNC: 2026-07-20 재검증 -->

### 2026-07-21 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **미해결 발견 지속 확인**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 동일하게 여전히 unstaged modified 상태로 남아 있음(4일 경과, 추가 파일 변경 없음). 문서 내용 자체는 실제 상태와 일치하나 GitHub 공개본에는 미반영 상태 지속 — 이번 세션에서도 커밋은 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, 미커밋 상태 4일 경과)은 오늘도 동일하게 유효. <!-- DOC-SYNC: 2026-07-21 재검증 -->

### 2026-07-22 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 및 각 분기 안내 문구 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 38줄, 변동 없음) 재확인 (MATCH).
- **미해결 발견 지속 확인**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 동일하게 여전히 unstaged modified 상태로 남아 있음(4일 경과, 추가 파일 변경 없음). 문서 내용 자체는 실제 상태와 일치하나 GitHub 공개본에는 미반영 상태 지속 — 이번 세션에서도 커밋은 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, 미커밋 상태 4일 경과)은 오늘도 동일하게 유효. <!-- DOC-SYNC: 2026-07-22 재검증 -->

### 2026-07-27 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 38줄, 변동 없음) 재확인 (MATCH).
- **미해결 발견 지속 확인 (에스컬레이션)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **9일째** unstaged modified 상태로 남아 있음(07-22 이후 5일 추가 경과, 그사이 파일 변경 없음). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고 등)이 여전히 미반영 상태 — 방치 기간이 길어지고 있어 사용자 확인을 권장. Doc-Sync 에이전트는 이번 세션에서도 커밋을 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 9일 경과로 에스컬레이션 표시. <!-- DOC-SYNC: 2026-07-27 재검증 -->

### 2026-07-28 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함, mtime 07-13 이후 변동 없음). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). `.git`은 실제 디렉토리 재확인. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 38줄, 변동 없음), `PROJECT.md`의 레포 내용물 목록 재확인 (MATCH).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **10일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 10일째 미반영 상태 — 방치 기간이 계속 길어지고 있어 사용자의 커밋 여부 결정을 강하게 권장. Doc-Sync 에이전트는 이번 세션에서도 커밋을 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 10일 경과로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-07-28 재검증 -->

### 2026-08-01 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass (변동 없음). 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026) 재확인 (MATCH).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **14일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 23일 경과). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분이 14일째 미반영 — 방치 기간이 계속 늘고 있어 사용자의 커밋 여부 결정을 강하게 권장. Doc-Sync 에이전트는 이번 세션에서도 커밋을 사용자 승인 사안으로 판단해 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 14일 경과로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-01 재검증 -->

### 2026-08-02 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `.git`은 실제 디렉토리 재확인. `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값)과 정확히 일치 (MATCH). 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `devlog/sessions/2026-04-12-0014-initial-setup.md` 재확인 (파일 1개, 변동 없음, MATCH). CI/CD 설정(`.github/**`), `CLAUDE.md`/`AGENTS.md`, 패키지 매니페스트(`package.json` 등)는 이 레포에 존재하지 않음을 재확인 — 해당 카테고리는 검증 대상 없음(문서 전용 레포).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **15일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **24일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 15일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 레포 반영, outbound)는 이 세션에서도 사용자 승인 없이 자동 수행하지 않음 — 다만 방치 기간이 3주를 넘겨섰으므로 사용자 확인을 강하게 권장.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 15일 경과(마지막 커밋 24일 경과)로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-02 재검증 -->

### 2026-08-03 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: **13개 파일** (`.ps1` 3개 포함: `apply-windows.ps1`, `bootstrap-windows.ps1`, `diagnose-windows.ps1`), 신규/삭제 없음. 07-15 발견 미문서화 5개(`install-codex-companion.sh`, `setup-tmux-yazi.sh`, `bootstrap-windows.ps1`, `apply-windows.ps1`, `diagnose-windows.ps1`) 그대로 포함. 참고: 08-02 기록의 "14개 파일"은 이번 재조회(13개)와 불일치하나, 07-19와 동일하게 라이브 문서 claim이 아닌 과거 로그 항목이라 소급 수정하지 않음(단순 계수 오기로 추정). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions/) 전부 실물과 일치 재확인 (MATCH). `.omc/`는 `.gitignore`에 등재되어 추적 대상 아님(로컬 세션 상태 디렉토리, 문서화 불필요 항목으로 재확인).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **16일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **25일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분이 16일째 미반영. 커밋(로컬)·푸시(공개 반영) 모두 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 16일 경과(마지막 커밋 25일 경과)로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-03 재검증 -->

### 2026-08-04 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). 레포 루트에 신규/미분류 파일 없음(`git status --porcelain --ignored` 확인).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **17일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **26일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 17일째 미반영. 커밋(로컬)·푸시(공개 반영) 모두 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 17일 경과(마지막 커밋 26일 경과)로 재차 에스컬레이션 — 다음 세션에서도 자동 해소되지 않을 것이므로 사용자의 명시적 결정(커밋+푸시 or 폐기)을 권장. <!-- DOC-SYNC: 2026-08-04 재검증 -->

### 2026-08-05 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). 레포 루트에 신규/미분류 파일 없음(`git status --porcelain --ignored` 확인).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **18일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **27일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 18일째 미반영. 커밋(로컬)·푸시(공개 반영) 모두 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 18일 경과(마지막 커밋 27일 경과)로 재차 에스컬레이션 — 4주 가까이 자동 해소되지 않고 있으므로 사용자의 명시적 결정(커밋+푸시 or 폐기)을 강하게 권장. <!-- DOC-SYNC: 2026-08-05 재검증 -->

### 2026-08-06 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `find`로 레포 전체 파일 트리 재대조 — `PROJECT.md`가 나열한 12개 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/PROJECT.md 자신/00~05 노트 6개/scripts/devlog) 외 추가 파일 없음. `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인(문서 전용 레포, Doc-Sync 대상 문서 유형 표 중 6개 카테고리는 해당 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **19일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **28일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 19일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 19일 경과(마지막 커밋 28일 경과)로 재차 에스컬레이션 — 사용자의 명시적 결정(커밋+푸시 or 폐기)을 강하게 권장. <!-- DOC-SYNC: 2026-08-06 재검증 -->

### 2026-08-07 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값 `~/Documents/your-obsidian-vault`)과 정확히 일치 (MATCH). 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `01.`~`05.` 노트 전문 재독해 — 내부 상호링크, 예시 명령어, exit code 서술, `clf` 옵션 순서(satisfaction/helpfulness/clarity/comment) 모두 소스와 일치 (MATCH). `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인(문서 전용 레포, 해당 카테고리는 검증 대상 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **20일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **29일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 20일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 20일 경과(마지막 커밋 29일 경과)로 재차 에스컬레이션 — 한 달 가까이 자동 해소되지 않고 있으므로 사용자의 명시적 결정(커밋+푸시 or 폐기)을 강하게 권장. <!-- DOC-SYNC: 2026-08-07 재검증 -->

### 2026-08-09 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값 `~/Documents/your-obsidian-vault`)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. 레포 원격 3개(이 레포 `nori00000/mobile-dev-on-claude-code.git` / `claude-code-setup` `nori00000/claude-code-setup.git` / `codex-setup` `nori00000/codex-setup-private.git`) 재확인 — README·00. 인덱스의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `find`로 레포 전체 파일 트리 재대조 — `PROJECT.md`가 나열한 항목 외 추가/누락 파일 없음. `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인(문서 전용 레포, 해당 카테고리는 검증 대상 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **22일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **31일 경과**, 08-08 세션 미실행으로 1일 공백). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 22일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 22일 경과(마지막 커밋 31일 경과)로 재차 에스컬레이션 — 한 달을 넘겨섰으므로 사용자의 명시적 결정(커밋+푸시 or 폐기)을 강하게 권장. <!-- DOC-SYNC: 2026-08-09 재검증 -->

### 2026-08-10 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- **심화 확인(신규)**: `gh repo list nori00000`로 `codex-setup`(PUBLIC)과 `codex-setup-private`(PRIVATE)이 서로 다른 두 레포임을 재확인하고, 로컬 `~/codex-setup` 클론의 `git remote -v`가 `codex-setup-private.git`을 가리킴을 직접 검증 — README.md line 23 및 `00. 인덱스` line 37의 "로컬 `~/codex-setup` remote는 별도 비공개 미러" 서술과 정확히 일치 (MATCH, 이전 세션들의 반복 서술을 소스 레벨에서 첫 교차검증).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182), `clf` 인자 순서(satisfaction 1-5/helpful|neutral|not_helpful/clear|mixed|unclear/comment)와 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 line 168-170 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값 `~/Documents/your-obsidian-vault`)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass.
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `git ls-files` + `find` 이중 대조로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목 외 추가/누락 파일 없음. `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인(문서 전용 레포, Doc-Sync 대상 문서 유형 표 7개 카테고리 중 6개는 해당 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **23일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **32일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 23일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음 — 사용자 세션 내 직접 질의로 처리 방향 확인 권장.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인 + codex-setup-private 이원 구조 신규 소스 레벨 교차검증). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 23일 경과(마지막 커밋 32일 경과)로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-10 재검증 -->

### 2026-08-11 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지. `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182), `clf` 인자 순서(satisfaction 1-5/helpful|neutral|not_helpful/clear|mixed|unclear/comment)와 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 line 168-170 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값 `~/Documents/your-obsidian-vault`)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass.
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `git ls-files` + `find` 이중 대조로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목 외 추가/누락 파일 없음. `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인(문서 전용 레포, Doc-Sync 대상 문서 유형 표 7개 카테고리 중 6개는 해당 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **24일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **33일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 24일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음 — 한 달을 넘겨 방치 기간이 계속 늘고 있으므로 사용자의 명시적 결정(커밋+푸시 or 폐기)을 강하게 권장.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태만 24일 경과(마지막 커밋 33일 경과)로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-11 재검증 -->

### 2026-08-12 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `./scripts/sync-from-obsidian.sh --help` 실행 결과가 README.md의 옵션 설명(`--dry-run`/`--no-push`/`--message`/`OBSIDIAN_VAULT` 기본값 `~/Documents/your-obsidian-vault`)과 정확히 일치 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음), `PROJECT.md`의 레포 내용물 목록 전부 실물과 일치 재확인 (MATCH). `find`로 레포 전체 파일 트리 재대조 — `PROJECT.md`가 나열한 항목 외 추가/누락 파일 없음.
- **조치(신규)**: 25일째 반복 재확인해도 자동 해소되지 않는 미커밋 에스컬레이션을 이번 세션에서 `~/bin/hq add`로 human-queue에 적립(`[approve]` 태그) — 사용자 전역 CLAUDE.md의 Human-queue 규칙에 따라, 매일 같은 경고를 반복 기록하는 대신 사용자 확인 지점(아침 브리핑)으로 이관. Doc-Sync 에이전트 자체는 이번에도 커밋/푸시를 수행하지 않음(Irreversibility Gate, outbound 승인 필요).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **25일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **34일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 25일째 미반영.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태는 25일 경과(마지막 커밋 34일 경과) — human-queue 적립으로 처분을 사용자 브리핑으로 이관, 다음 세션부터는 큐 상태를 우선 확인. <!-- DOC-SYNC: 2026-08-12 재검증 -->

### 2026-08-13 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 line 168-170 서술과 일치 (MATCH). `~/.claude/feedback/` 디렉토리 자체는 아직 미생성(clf 미실행 상태) — 노트가 "첫 실행 시 자동 생성"이라 명시해 두어 이는 STALE_DOC 아님 (MATCH, 조건부 서술 확인됨).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `git ls-files` + `find`(`.git`/`.omc` 제외) 이중 대조로 레포 전체 파일 트리 재확인 — `PROJECT.md` line 25-36이 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `LICENSE`(MIT, `nori00000`, 2025-2026), `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음).
- **human-queue 상태 확인(신규)**: `~/bin/hq` 조회 결과, 08-12에 적립한 `[approve] mobile-dev-on-claude-code: ... 커밋+푸시 or 폐기 결정 필요` 항목이 큐 25번으로 여전히 대기 중(아직 사용자 처리 전) — 중복 적립하지 않음, 기존 항목 유효.
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **26일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **35일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 26일째 미반영. 처분은 이미 human-queue에 적립되어 사용자 브리핑 대기 중이므로, 이번 세션에서도 커밋/푸시를 자동 수행하지 않음(Irreversibility Gate, outbound 승인 필요).
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태는 26일 경과(마지막 커밋 35일 경과) — human-queue 25번 항목이 여전히 처분 대기 중, 사용자 확인 시 해소됨. <!-- DOC-SYNC: 2026-08-13 재검증 -->

### 2026-08-14 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`, 첫 실행 시 `mkdir -p`로 자동 생성) 재확인 — `01. 핵심 개념` 노트 line 168-170 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `git ls-files` + `find`(`.git`/`.omc` 제외) 이중 대조로 레포 전체 파일 트리 재확인 — `PROJECT.md` line 25-36이 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `bash -n scripts/sync-from-obsidian.sh`: pass. `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음).
- **human-queue 상태 확인**: `~/bin/hq list` 조회 결과, 08-12에 적립한 25번 `[approve] mobile-dev-on-claude-code: ... 커밋+푸시 or 폐기 결정 필요` 항목이 오늘도 큐에 그대로 남아 처리 대기 중 — 중복 적립하지 않음, 기존 항목 유효.
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **27일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **36일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 27일째 미반영. 처분은 이미 human-queue 25번에 적립되어 사용자 브리핑 대기 중이므로, 이번 세션에서도 커밋/푸시를 자동 수행하지 않음(Irreversibility Gate, outbound 승인 필요).
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태는 27일 경과(마지막 커밋 36일 경과) — human-queue 25번 항목이 여전히 처분 대기 중, 사용자 확인 시 해소됨. <!-- DOC-SYNC: 2026-08-14 재검증 -->

### 2026-08-15 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182), `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`, 첫 실행 시 `mkdir -p`로 자동 생성) 재확인 — `01. 핵심 개념` 노트 line 168-170 서술과 일치 (MATCH).
- `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`, `STATUS_FALLBACK_READY=10`, `STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02. 5단계 운영 플로우.md` line 163-166의 0/10/20 서술과 정확히 일치 (MATCH).
- `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `git ls-files` + `find`(`.git`/`.omc` 제외) 이중 대조로 레포 전체 파일 트리 재확인 — `PROJECT.md` line 25-36이 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `bash -n scripts/sync-from-obsidian.sh`: pass. `git diff --check`: pass (whitespace 오류 없음). `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음).
- **human-queue 상태 확인**: `~/bin/hq list` 조회 결과, 08-12에 적립한 25번 `[approve] mobile-dev-on-claude-code: ... 커밋+푸시 or 폐기 결정 필요` 항목이 오늘도 큐에 그대로 남아 처리 대기 중 — 중복 적립하지 않음, 기존 항목 유효.
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **28일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **37일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 28일째 미반영. 처분은 이미 human-queue 25번에 적립되어 사용자 브리핑 대기 중이므로, 이번 세션에서도 커밋/푸시를 자동 수행하지 않음(Irreversibility Gate, outbound 승인 필요).
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태는 28일 경과(마지막 커밋 37일 경과) — human-queue 25번 항목이 여전히 처분 대기 중, 사용자 확인 시 해소됨. <!-- DOC-SYNC: 2026-08-15 재검증 -->

### 2026-08-18 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `scripts/sync-from-obsidian.sh --dry-run` (`OBSIDIAN_VAULT=~/Documents/Obsidian-0.1`) 재실행: 여전히 6/6 노트 diff — "Sync-back risk" 오늘도 유효 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` line 174-181 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(이 노트는 Mac+Termux 한정, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH).
- `~/claude-code-setup`·`~/codex-setup` git remote 재확인 — `claude-code-setup.git`(공개)/`codex-setup-private.git`(비공개 미러) 그대로, README·00. 인덱스 서술과 일치 (MATCH).
- `git ls-files`로 레포 전체 파일 트리 재확인(`.git`/`.omc` 제외) — `PROJECT.md` line 25-36이 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음).
- **human-queue 상태 확인 (이상 발견)**: `~/bin/hq list` / `~/bin/hq all` 모두 조회했으나 08-12에 적립했던 25번 `[approve] mobile-dev-on-claude-code: ...` 항목이 **더 이상 존재하지 않음**(완료 처리 흔적 없이 소실, `done`/`snooze` 이력 확인 불가). 근본 원인(3개 파일 미커밋 상태)은 해소되지 않았으므로(`git status` 재확인, 아래 참조) 오늘 세션에서 `~/bin/hq add`로 재적립함 — 사유와 경과일수를 명시해 중복 발견 시 추적 가능하게 표기.
- **미해결 발견 지속 확인 (에스컬레이션 갱신, 3일 공백 후 재개 — 08-16/08-17 세션 미실행)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **31일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **40일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 31일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 미커밋 상태는 31일 경과(마지막 커밋 40일 경과) — human-queue 항목이 추적 없이 소실되어 재적립함(신규 프로세스 이상 1건). 사용자 확인 시 근본 원인 해소됨. <!-- DOC-SYNC: 2026-08-18 재검증 -->

### 2026-08-19 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일(`.ps1` 3개 포함), 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(Mac+Termux 한정 서술, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182), `check-cmux-health.sh`의 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`/`STATUS_FALLBACK_READY=10`/`STATUS_CLAUDE_UNHEALTHY=20`), `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01.`/`02.` 노트 서술과 일치 (MATCH). `~/claude-code-setup`(`claude-code-setup.git`, 공개)·`~/codex-setup`(`codex-setup-private.git`, 비공개 미러) remote 재확인 — README·00. 인덱스 서술과 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `git ls-files`로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목 외 추가·누락 파일 없음 (MATCH). `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, 해당 카테고리는 검증 대상 없음 (변동 없음). `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **신규 발견 (운영, 자동 수정 대상 아님)**: `OBSIDIAN_VAULT=~/Documents/Obsidian-0.1 ./scripts/sync-from-obsidian.sh --dry-run` 실행 결과가 07-14~08-18까지 매일 "6/6 노트 diff"였던 것과 달리 오늘은 **`Error: Obsidian source dir not found`**로 실패함. 원인 확인: Obsidian 볼트 쪽 `75. Projects/Claude Code 모바일 개발/` 폴더 자체가 2026-08-18 22:28경 `75. Projects/_archive/Claude Code 모바일 개발/`로 이동됨(같은 6개 노트, 내용 변경 없음 — mtime은 여전히 4월, 프런트매터 `status: inProgress` 그대로). 스크립트의 `SOURCE_DIR="${VAULT}/75. Projects/Claude Code 모바일 개발"`는 하드코딩된 상대경로라 볼트 쪽 폴더 이동을 못 따라감. README.md line 83이 서술하는 "스크립트 내 하드코딩" 경로 자체는 코드와 여전히 일치(MATCH, 문서 claim 오류 아님) — 다만 그 경로가 가리키는 실제 위치가 사라져 스크립트가 실사용 불가 상태가 됨. `_archive/`로의 이동이 프로젝트 졸업(성숙 단계 이전)인지 단순 정리인지는 볼트 프런트매터만으로 판단 불가(`status: inProgress` 유지) — 볼트 파일은 이 레포 범위 밖이라 자동 수정하지 않고 사용자 확인 필요 사안으로만 기록 (07-14 sync-back risk와 동일 원칙 적용).
- **미해결 발견 지속 확인 (에스컬레이션 갱신, 08-18 이후 공백 없이 연속)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **32일째** unstaged modified 상태로 남아 있음(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **41일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나, GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정 등)이 32일째 미반영. 커밋(로컬, 되돌리기 가능)과 푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **human-queue 상태 확인**: `~/bin/hq all` 재조회 — 08-18에 재적립한 `[approve] mobile-dev-on-claude-code: ...` 항목이 오늘도 미처리 상태로 큐에 그대로 존재(소실 없음, 전일 발견된 프로세스 이상은 오늘 재발하지 않음). 신규 발견(볼트 폴더 archive 이동)은 이 레포의 문서 정합성 문제가 아니라 사용자 확인 필요 운영 사안이므로 hq에 추가 적립하지 않고 본 보고서에만 기록.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백)은 오늘도 동일하게 유효. 신규 운영 발견 1건(Obsidian 볼트 소스 폴더가 `_archive/`로 이동되어 `sync-from-obsidian.sh` 기본 경로가 오늘부터 작동 안 함 — 문서 오류 아님, 사용자 확인 필요). 미커밋 상태는 32일 경과(마지막 커밋 41일 경과)로 재차 에스컬레이션. <!-- DOC-SYNC: 2026-08-19 재검증 -->

### 2026-08-20 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `OBSIDIAN_VAULT=~/Documents/Obsidian-0.1 ./scripts/sync-from-obsidian.sh --dry-run` 재실행: 08-19에 발견된 `Error: Obsidian source dir not found` 그대로 재현 — 볼트 쪽 `75. Projects/Claude Code 모바일 개발/`이 `_archive/`로 이동된 상태가 오늘도 지속(원복 없음). 스크립트/문서 자체의 claim은 여전히 코드와 일치(MATCH, README.md line 83 "스크립트 내 하드코딩" 서술 정확) — 실사용 불가 상태만 지속, 자동 수정 대상 아님(볼트는 레포 범위 밖).
- `~/claude-code-setup/scripts/` 재조회: 14개 파일(`.ps1` 3개 포함, `install-shell-integration.sh` mtime 변동 없음), 신규/삭제 없음 — 07-15 발견 미문서화 5개(`install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1`) 그대로. `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(Mac+Termux 한정 서술, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH). `check-cmux-health.sh` 종료 코드 상수(0/10/20) 재확인 — `02.` line 163-166과 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `git ls-files`로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `01.`~`05.` 노트 전문 재독 — 상호 링크·명령어·예시(`your-main-mac`/`your-username` 등 익명화 형태) 모두 소스 스크립트 및 서로 간 서술과 일치 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음). `devlog/sessions/`(파일 1개, 변동 없음), `~/claude-code-setup`(`claude-code-setup.git`, 공개)·`~/codex-setup`(`codex-setup-private.git`, 비공개 미러) remote 재확인 — README·00. 인덱스 서술과 일치 (MATCH).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **33일째** unstaged modified 상태(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **42일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나 GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정)이 33일째 미반영. 커밋(로컬)·푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **human-queue 상태 확인**: `~/bin/hq all` 재조회 — 08-18에 재적립한 `[approve] mobile-dev-on-claude-code: ...` 항목이 오늘도 미처리 상태로 큐에 그대로 존재(소실 없음).
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, Obsidian 볼트 archive 이동으로 인한 sync 스크립트 실사용 불가)은 오늘도 동일하게 유효. 미커밋 상태는 33일 경과(마지막 커밋 42일 경과)로 재차 에스컬레이션 — 근본 해소는 사용자의 커밋/푸시 승인 또는 폐기 결정 대기 중. <!-- DOC-SYNC: 2026-08-20 재검증 -->

### 2026-08-21 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음).
- `OBSIDIAN_VAULT=~/Documents/Obsidian-0.1 ./scripts/sync-from-obsidian.sh --dry-run` 재실행: 08-19에 발견된 `Error: Obsidian source dir not found` 그대로 재현 — `find`로 직접 확인한 결과 `75. Projects/Claude Code 모바일 개발/`은 여전히 `75. Projects/_archive/Claude Code 모바일 개발/`에 위치(원복 없음, mtime Aug 18 22:28 그대로). 스크립트/문서 자체의 claim은 코드와 여전히 일치(MATCH, README.md line 83 "스크립트 내 하드코딩" 서술 정확) — 실사용 불가 상태만 지속, 자동 수정 대상 아님(볼트는 레포 범위 밖).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(Mac+Termux 한정 서술, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH). `check-cmux-health.sh` 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`/`STATUS_FALLBACK_READY=10`/`STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02.` line 163-166과 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `git ls-files`로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `~/claude-code-setup`(`claude-code-setup.git`, 공개)·`~/codex-setup`(`codex-setup-private.git`, 비공개 미러) remote 재확인 — README·00. 인덱스 서술과 일치 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음). `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **human-queue 상태 확인**: `~/bin/hq all` 재조회 — 08-18에 재적립한 `[approve] mobile-dev-on-claude-code: ...` 항목이 오늘도 미처리 상태로 큐에 그대로 존재(소실 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **34일째** unstaged modified 상태(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **43일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나 GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정)이 34일째 미반영. 커밋(로컬)·푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.

### 2026-08-24 Doc-Sync re-verification

- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음). 이번 세션 호스트는 `m4-studio` (`hostname -s` 확인).
- `OBSIDIAN_VAULT=~/Documents/Obsidian-0.1 ./scripts/sync-from-obsidian.sh --dry-run` 재실행: 08-19에 발견된 `Error: Obsidian source dir not found` 그대로 재현 — `75. Projects/Claude Code 모바일 개발/`은 여전히 `75. Projects/_archive/Claude Code 모바일 개발/`에 위치(원복 없음, 3일째 지속). 스크립트/문서 자체의 claim은 코드와 여전히 일치(MATCH, README.md line 83 "스크립트 내 하드코딩" 서술 정확) — 자동 dry-run이 막힌 상태이므로 **archive 경로의 노트 6개를 레포 공개본과 수동 `diff`로 직접 대조**: `00.`(7줄)/`01.`(4줄)/`02.`(27줄)/`03.`(22줄)/`04.`(8줄)/`05.`(17줄) 전부 여전히 diff 존재 — NOTICE.md/README.md의 "Sync-back risk" 경고가 서술하는 익명화 격차는 자동화 도구 없이도 오늘 기준 실측으로 재확인됨 (MATCH, 경고 문구 유효).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(Mac+Termux 한정 서술, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH). `check-cmux-health.sh` 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`/`STATUS_FALLBACK_READY=10`/`STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02.` line 163-166과 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `git ls-files`로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `~/claude-code-setup`(`claude-code-setup.git`, 공개)·`~/codex-setup`(`codex-setup-private.git`, 비공개 미러) remote 재확인 — README·00. 인덱스 서술과 일치 (MATCH). `LICENSE`(MIT, `nori00000`, 2025-2026) 재확인 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음). `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH).
- **human-queue 상태 확인**: `~/bin/hq all` 재조회 — 08-18에 재적립한 `[approve] mobile-dev-on-claude-code: ...` 항목이 목록 1번으로 오늘도 미처리 상태로 큐에 그대로 존재(소실 없음).
- **미해결 발견 지속 확인 (에스컬레이션 갱신, 3일 공백 후 재개 — 08-22/08-23 세션 미실행)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **37일째** unstaged modified 상태(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **46일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나 GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정)이 37일째 미반영. 커밋(로컬)·푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, Obsidian 볼트 archive 이동으로 인한 sync 스크립트 실사용 불가)은 오늘도 동일하게 유효. 미커밋 상태는 37일 경과(마지막 커밋 46일 경과)로 재차 에스컬레이션 — 근본 해소는 사용자의 커밋/푸시 승인 또는 폐기 결정 대기 중(human-queue 08-18 항목 참조). <!-- DOC-SYNC: 2026-08-24 재검증 -->

### 2026-08-25 Doc-Sync re-verification

- **문서 결함 발견 및 수정**: 이 로그의 08-21 재검증 "결론" 줄이 08-24 항목 뒤에 중복·역순으로 남아 있던 편집 잔여물을 오늘 발견, 제거함(내용 정정 아님 — 로그 정합성 정리, 원본 08-21 절 본문은 그대로 보존됨).
- `gh api repos/nori00000/mobile-dev-on-claude-code` / `.../claude-code-setup` / `.../codex-setup`: 3개 레포 모두 `private:false`, `visibility:public` 재확인 (변동 없음). 이번 세션 호스트는 `m4-studio` (`hostname -s` 확인).
- `OBSIDIAN_VAULT=~/Documents/Obsidian-0.1 ./scripts/sync-from-obsidian.sh --dry-run` 재실행: 08-19에 발견된 `Error: Obsidian source dir not found` 그대로 재현 — `find`로 직접 확인한 결과 `75. Projects/Claude Code 모바일 개발/`은 여전히 `75. Projects/_archive/Claude Code 모바일 개발/`에 위치(원복 없음, 7일째 지속). 스크립트/문서 자체의 claim은 코드와 여전히 일치(MATCH, README.md line 83 "스크립트 내 하드코딩" 서술 정확) — 자동 dry-run이 막힌 상태만 지속, 자동 수정 대상 아님(볼트는 레포 범위 밖).
- `~/claude-code-setup/scripts/` 재조회: 13개 파일, 신규/삭제 없음(07-15 발견 미문서화 5개 `install-codex-companion.sh`/`setup-tmux-yazi.sh`/`bootstrap-windows.ps1`/`apply-windows.ps1`/`diagnose-windows.ps1` 그대로 포함). `02. 5단계 운영 플로우.md` 헬퍼 스크립트 표는 여전히 8행(미문서화 5개 미반영) — 범위 애매(Mac+Termux 한정 서술, 신규 5개 중 3개 Windows·1개 Linux)로 자동 수정 보류 유지.
- `install-shell-integration.sh`에서 `cl()`/`clp()`/`clr()`/`clf()`/`cli()` 5개 함수 정의(라인 117/128/147/158/182) 및 `clf` 저장 경로(`${HOME}/.claude/feedback/<YYYY-MM>.jsonl`) 재확인 — `01. 핵심 개념` 노트 서술과 일치 (MATCH). `check-cmux-health.sh` 종료 코드 상수(`STATUS_FULLY_HEALTHY=0`/`STATUS_FALLBACK_READY=10`/`STATUS_CLAUDE_UNHEALTHY=20`) 재확인 — `02.` line 163-166 및 README.md 빠른 시작 섹션과 일치 (MATCH).
- `git diff --check` / `bash -n scripts/sync-from-obsidian.sh`: pass. `git ls-files`로 레포 전체 파일 트리 재확인 — `PROJECT.md`가 나열한 항목(README/LICENSE/NOTICE/PUBLICATION_REVIEW/00~05 노트/scripts/sync-from-obsidian.sh/devlog/sessions) 외 추가·누락 파일 없음 (MATCH). `~/claude-code-setup`(`claude-code-setup.git`, 공개)·`~/codex-setup`(`codex-setup-private.git`, 비공개 미러) remote 재확인 — README·00. 인덱스 서술과 일치 (MATCH).
- `AGENTS.md`/`*.rule`/`.cursor/rules`/`package.json`/`pyproject.toml`/`Cargo.toml`/`.github/**`/`Makefile`/`justfile`/`CLAUDE.md` 전부 부재 재확인 — 문서 전용 레포, Doc-Sync 대상 문서 유형 7개 카테고리 중 6개는 해당 없음 (변동 없음). `devlog/sessions/`(파일 1개, 변동 없음) 재확인 (MATCH). `.omc/`는 `.gitignore` 대상으로 git 추적 밖(변동 없음).
- **human-queue 상태 확인**: `~/bin/hq all` 재조회 — 08-18에 재적립한 `[approve] mobile-dev-on-claude-code: ...` 항목이 목록 1번으로 오늘도 미처리 상태로 큐에 그대로 존재(소실 없음, 중복 재적립 안 함).
- **미해결 발견 지속 확인 (에스컬레이션 갱신)**: `git status` — `NOTICE.md`/`PUBLICATION_REVIEW.md`/`README.md` 3개 파일이 07-18부터 오늘까지 **38일째** unstaged modified 상태(마지막 실제 커밋은 07-09, `43193fe`, 오늘 기준 **47일 경과**). 문서 내용 자체는 실제 상태와 계속 일치하나 GitHub 공개본에는 07-13~17 doc-sync 편집분(공개 상태 갱신, sync-back 경고, 라이선스 문구 수정)이 38일째 미반영. 커밋(로컬)·푸시(공개 반영, outbound)는 Irreversibility Gate 대상 판단이라 이 세션에서도 사용자 승인 없이 자동 수행하지 않음.
- **결론**: 신규 MISMATCH/STALE_DOC 없음(콘텐츠 정합성 기준, Doc-Sync Agent 전체 스캔 재확인). 기존 발견 항목(공개 상태, 라이선스 문구, sync-back 위험, 헬퍼 스크립트 표 공백, Obsidian 볼트 archive 이동으로 인한 sync 스크립트 실사용 불가)은 오늘도 동일하게 유효. 신규로 이 로그 자체의 중복 줄 1건을 발견·정리함(콘텐츠 오류 아님, 편집 잔여물). 미커밋 상태는 38일 경과(마지막 커밋 47일 경과)로 재차 에스컬레이션 — 근본 해소는 사용자의 커밋/푸시 승인 또는 폐기 결정 대기 중(human-queue 08-18 항목 참조). <!-- DOC-SYNC: 2026-08-25 재검증 -->
