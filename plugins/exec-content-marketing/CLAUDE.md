# exec-content-marketing

ION 콘텐츠 마케팅 팀장용 업무 환경. `exec-base` 를 전제로 하며, 영상 광고 스토리보드·대본 5개 기획을 자동화한다.

## 사용자
- **1차 사용자: 민지 (실무 컨펌자)** — 2026-05-10 이후 직접 사용 시작. 현승 팀장 퇴사(2026-05-10 주말 전 확정)로 파일럿 단계 생략, 민지님이 1차 사용자로 직행.
- 현승 (前 콘텐츠 마케팅 팀장, ~2026-05-09): 잔여 1주 마지막 검증 + 민지님 인수인계. 본 플러그인의 모든 룰·암묵지 원천. 퇴사 후 `knowledge/` 5종 원문이 권위의 유일 소스.
- 최종 생산 주체: 콘텐츠 마케터 5명 (일 45개 영상 베리에이션 제작 — 대본 기획이 매일의 병목, 민지님 컨펌).
- 운영자 (성수): 2-tier 피드백 검토 + 정식 룰 승격. 현승 부재로 모호한 케이스는 민지님과 직접 협의 후 결정.

## 의존성
- `exec-base` 설치 전제 (출력 원칙·공통 hooks·exec-briefing 포맷 상속).
- ATMS MCP **사용 안 함** (광고 운영 데이터 영역은 `exec-marketing` 담당).
- **Playwright MCP** 가정 (사용자 로컬 settings.json 에서 연결). `brand-researcher` / `competitor-landscape` subagent 의 JS 렌더링·iframe·스크린샷에 필수.
- 외부 API (Tavily/Exa/네이버 API 등) 없음 — 사용자 키 관리 부담 회피.

## 주요 자산
- `commands/draft-storyboard.md` — 스토리보드/대본 5개 기획 슬래시 커맨드 (storyboard-writer 페르소나 + 4단계 파이프라인 + 피드백 루프 본문). 본 플러그인의 진입점.
- `agents/brand-researcher.md` — 단일 브랜드 심층 리서치 subagent.
- `agents/competitor-landscape.md` — 경쟁사 파노라마 + 트렌드 subagent.
- `knowledge/01-시장-조사.md` / `02-USP-추출-체크리스트.md` / `03-소구-도출-철학.md` ★ / `04-영상-콘텐츠-체크리스트.md` / `05-이미지-컨텐츠-체크리스트.md` — 현승님 암묵지 원문 5종.
- `feedback-pending.md` — 사용자 피드백 영속화 Tier 2 (운영자 검토 큐, git 추적).
- `AGENT_PLAN.md` — 본 플러그인 구축 계획·진척·결정 이력.

## 피드백 영속화 메커니즘
`/draft-storyboard` (C) 옵션 6 "룰" 응답은 2-tier 로 영속화된다.
1. **Tier 1** (`~/.claude/exec-content-marketing/user-feedback.md`, 사용자 홈, git 무시) — 응답 즉시 단계 태깅(②/③/④/공통)과 함께 append. 다음 세션 시작 시 자동 주입.
2. **Tier 2** (본 플러그인 내부 `feedback-pending.md`, git 추적) — `/draft-storyboard` 첫 단계(⓪ 영속화)에서 24h 1회 자동 동기화. 운영자 검토 큐.
3. 운영자(콘텐츠 마케팅 팀장) 정렬 회차에 정식 룰로 `commands/draft-storyboard.md` 반영. git add/commit/push 는 자동 안 함.

상세는 `commands/draft-storyboard.md` ⓪ 섹션과 `AGENT_PLAN.md` 참조.

## 작업 원칙 (도메인 특화)
- 룰·임계값·라벨은 `knowledge/` 5종 원문에 있는 것만 사용. 임의 분류·수치 박지 않음 (`feedback_user_audits_knowledge_provenance.md`).
- 본문 인용 정보는 자사 컨트롤 가능한 정보만 (인용 정보 게이트 — 타사 리뷰 수·평점·경쟁사 절대 가격·인플루언서 도달 수치 등 변동성·신뢰성 의심 데이터 금지).
- 매체별 보조 지시문·분기 로직 없음 (knowledge 에 매체별 가이드가 없음). 매체는 맥락 정보로만 받음.

## 범위 외 (의도적)
- **이미지 소재 기획** — 차기 `image-brief-writer` 에이전트로 분리 예정. `knowledge/05-이미지-컨텐츠-체크리스트.md` 는 그 용도로 보관.
- **영상 편집 포인트** — 회의 후순위.
- **촬영 기획안 초안** — 빈도 낮음.
- **광고 운영 진단·리포팅** — `exec-marketing` 영역.
