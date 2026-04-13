---
description: 특정 캠페인 ID에 대해 ATMS campaign_diagnosis 를 호출하고 팀장 보고 포맷으로 요약한다.
argument-hint: "<campaign_id> [기간: 기본값 최근 7일]"
---

ads-ops 에이전트에게 다음 업무를 위임한다.

**인자**: $ARGUMENTS

다음을 수행하라:
1. 인자에서 `campaign_id` 와 (선택) 기간을 파싱한다. `campaign_id` 가 비어 있으면 한 번만 되묻고 종료한다.
2. `campaign_lookup` 으로 캠페인 메타(매체, 목표, 상태, 예산)를 확인한다.
3. `campaign_diagnosis` 를 호출해 원인 분석 결과를 받는다.
4. 필요 시 `campaign_performance_summary`, `campaign_operational_insights` 로 보조 수치를 확보한다.
5. 결과를 다음 포맷으로 정리한다:
   - **캠페인 개요**: 이름 / 매체 / 상태 / 예산 / 기간
   - **현황 수치**: 노출·클릭·전환·매출·ROAS (전기간 대비 %)
   - **원인 후보**: 2~3개, 각 근거 수치 포함
   - **권장 조치**: 예산·소재·타겟 관점, 예상 임팩트 1줄
   - **승인 필요 여부**: Yes/No

실제 집행 변경(정지/증액)은 절대 자동 실행하지 않는다. 제안까지만.
