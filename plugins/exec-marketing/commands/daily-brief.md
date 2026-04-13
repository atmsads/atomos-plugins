---
description: 마케팅팀장용 일일 광고 브리핑 생성. 어제 성과·이상치·승인 필요 항목을 exec-briefing 포맷으로 보고한다.
argument-hint: "[기간: 기본값 어제]"
---

ads-ops 에이전트에게 다음 업무를 위임한다.

**대상 기간**: $ARGUMENTS (없으면 "어제")

다음을 수행하라:
1. ATMS MCP 도구로 대상 기간의 전체 성과를 집계한다:
   - `company_ad_performance_summary` — 회사 단위 총 소진·매출·ROAS
   - `company_roi_summary` — 수익성
   - 필요 시 `campaign_performance_summary` 로 상위 캠페인 드릴다운
2. 직전 동일 기간 대비 변동폭을 계산하고, 이상치(급락/급등 ±30% 이상) 캠페인을 식별한다.
3. 이상치가 있으면 `campaign_diagnosis` 로 원인 후보를 뽑는다.
4. 결과를 `exec-briefing` 포맷으로 정리한다:
   - 핵심 요약 (2줄)
   - 주요 변동 지표 (3~5 bullet)
   - 리스크 / 이슈
   - 의사결정 필요 항목 (Yes/No 명시)
   - 다음 액션

수치 근거는 어떤 MCP 도구의 결과인지 괄호로 표기한다.
