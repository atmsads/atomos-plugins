# exec-marketing

ION 마케팅팀장용 업무 환경. `exec-base`를 전제로 하며, ATMS MCP 연동을 통한 광고 운영·진단·리포팅에 특화되어 있다.

## 도메인 컨텍스트
- 주요 매체: Meta, Google, Naver, Kakao (ATMS 기준).
- 핵심 KPI: ROAS, CPA, 전환수, 매출, 소진율.
- 운영 단위: Workspace → Company → Campaign → Adset → Ad.

## 사용 가능한 MCP 도구
ATMS MCP 서버가 연결되어 있다. 대표 도구:
- `ad_lookup`, `adset_lookup`, `campaign_lookup` — 계층별 조회
- `*_diagnosis` — 성과 이슈 원인 분석
- `*_performance_summary` — 기간별 성과 요약
- `company_roi_summary`, `company_sales_summary` — 회사 단위 수익성
- `autorule_lookup`, `autorule_execution_insights` — 자동화 룰 운영 현황

## 작업 원칙
- 광고 성과 질문은 반드시 기간(오늘/어제/지난주/월초 누적)을 먼저 확정한다.
- 수치 보고 시 절대값 + 전기간 대비 증감률을 함께 제시.
- 이상치(-50% 이하 급락, +100% 이상 급등)는 원인 분석을 먼저 제안한다.
- 팀장이 의사결정해야 하는 케이스(예산 증액/중단)는 `exec-briefing` 포맷으로 정리한다.

## 확장
- `agents/ads-ops.md` — 광고 운영 집중 에이전트
- `skills/` — ATMS 기반 루틴 (추후 추가)
