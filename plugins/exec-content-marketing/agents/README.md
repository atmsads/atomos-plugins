# agents/

콘텐츠 마케팅 팀장용 서브 에이전트 정의서를 보관하는 디렉토리.

각 에이전트는 프론트매터(`name`, `description`) + 마크다운 본문 형식의 단일 `.md` 파일. Claude Code가 자동으로 로드해 Task 도구의 `subagent_type`으로 호출할 수 있게 한다.

## 예정 파일

- `storyboard-writer.md` — 영상 광고 스토리보드·대본 기획 에이전트
  - 4단계 파이프라인: 리서치 → 소구점(3+1 옵션) → 후킹 → 대본
  - 상세 스펙은 플러그인 루트의 `AGENT_PLAN.md` 참고

## 참고 템플릿

- `plugins/exec-marketing/agents/ads-ops.md`
