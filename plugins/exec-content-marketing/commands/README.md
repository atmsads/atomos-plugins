# commands/

사용자가 직접 호출하는 슬래시 커맨드 정의를 보관하는 디렉토리.

각 커맨드는 프론트매터 + 마크다운 본문의 단일 `.md` 파일. `$ARGUMENTS`로 사용자 입력을 받아 해당 에이전트를 기동시키는 얇은 트리거 역할.

## 예정 파일

- `draft-storyboard.md` — 브랜드명을 인자로 받아 `storyboard-writer` 에이전트를 호출하는 커맨드
  - 사용 예: `/draft-storyboard <브랜드명>`

## 참고 템플릿

- `plugins/exec-marketing/commands/daily-brief.md`
- `plugins/exec-marketing/commands/diagnose-campaign.md`
