# exec-base

ION 팀장 공통 업무 환경. 모든 팀별 plugin(exec-marketing, exec-sales 등)은 이 베이스를 전제로 동작한다.

## 공통 원칙
- 모든 응답은 한국어 기본. 전문 용어는 원문 병기.
- 팀장 관점: 실무자가 아니라 의사결정자 입장에서 요약·판단 근거·다음 액션을 먼저 제시한다.
- 민감 지표(매출, ROAS, CPA 등)는 출처와 기간을 반드시 명시한다.
- 외부 시스템 호출(MCP tool)은 결과 요약 + 원본 핵심 수치를 함께 보고한다.

## 공통 제공물
- `agents/exec-briefing.md` — 일일 브리핑 생성용 에이전트.
- `hooks/` — 공통 세션 훅 (후속 PR).
- `commands/` — 공통 슬래시 커맨드 (후속 PR).

## 확장 방법
팀별 plugin은 이 베이스의 agents/commands를 override하거나 팀 고유 도메인 지식을 `CLAUDE.md`에 덧붙인다.
