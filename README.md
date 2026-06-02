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
- [nori00000/codex-setup](https://github.com/nori00000/codex-setup) — 자매 프로젝트 (codex 버전)

## 목차

| 노트 | 내용 |
|------|------|
| [00. 인덱스](00.%20%F0%9F%8F%9B%20Claude%20Code%20%EB%AA%A8%EB%B0%94%EC%9D%BC%20%EA%B0%9C%EB%B0%9C%20%EC%9D%B8%EB%8D%B1%EC%8A%A4.md) | 전체 허브 노트 |
| [01. 핵심 개념](01.%20%ED%95%B5%EC%8B%AC%20%EA%B0%9C%EB%85%90%20%E2%80%94%20tmux%2C%20cl%2C%20clp.md) | tmux, cl, clp, clr, clf 쉬운 설명 |
| [02. 5단계 운영 플로우](02.%205%EB%8B%A8%EA%B3%84%20%EC%9A%B4%EC%98%81%20%ED%94%8C%EB%A1%9C%EC%9A%B0.md) | 시나리오별 사용법 |
| [03. Termux 안드로이드 설정](03.%20Termux%20%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C%20%EC%84%A4%EC%A0%95.md) | Android 실전 설치 가이드 |
| [04. 내 경험 기록](04.%20%EB%82%B4%20%EA%B2%BD%ED%97%98%20%EA%B8%B0%EB%A1%9D.md) | 실제 사용 로그 |
| [05. 트러블슈팅 노트](05.%20%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85%20%EB%85%B8%ED%8A%B8.md) | 시간순 문제/해결 |

## 빠른 시작

```bash
# 평소 작업 시작
cl "작업 내용"

# 다른 Mac에서 이어받기
~/claude-code-setup/scripts/sync-current-branch.sh && cl "작업"

# 스마트폰에서 긴급 수정
ssh your-main-mac
cd <프로젝트>
~/claude-code-setup/scripts/check-cmux-health.sh
cl "긴급 수정"

# cmux 불가 시 fallback
CL_NO_TMUX=1 cl "작업"
```

## 워크스페이스의 진화

이 레포는 3단계로 진화합니다:

1. **[현재] 경험 수집** — Obsidian 볼트 + 이 레포에서 활성 기록
2. **개념 성숙** — Obsidian `30. Permanent Notes/`로 이주
3. **교육 자료화** — 강의/워크숍용으로 다듬은 최종 버전

## 라이선스

개인 학습/경험 기록용. 자유롭게 참고하세요.

---

**Source of truth**: Obsidian 볼트의 `75. Projects/Claude Code 모바일 개발/`
**GitHub 레포**: 공개 버전 (마크다운 파일 동기화)
