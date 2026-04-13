#!/usr/bin/env bash
# scope-check.sh — UserPromptSubmit 훅 placeholder.
# 팀장 Claude Code 세션에서 허용되지 않은 업무(예: 타 팀 데이터 조회, 민감 자산 수정)를
# 걸러내기 위한 정책 검증 지점.
#
# 입력: stdin 으로 Claude Code가 JSON payload 전달 (user prompt 등).
# 출력 규약:
#   - exit 0 : 통과 (기본). stdout 출력은 사용자에게 보이지 않음.
#   - exit 2 : 차단. stderr 메시지는 사용자와 모델 모두에게 표시됨.
#   - 기타 non-zero : 에러로 취급, 모델에 전달되지 않음.
#
# 실제 룰은 후속 PR에서 구현 예정. 현재는 통과.

set -euo pipefail

# TODO: stdin JSON 파싱 → prompt 추출 → 금지 키워드/패턴 매칭.
# 예시 스켈레톤:
#   payload=$(cat)
#   prompt=$(printf '%s' "$payload" | jq -r '.prompt // empty')
#   if printf '%s' "$prompt" | grep -qiE '금지패턴'; then
#     echo "해당 범위는 팀장 권한 외입니다." >&2
#     exit 2
#   fi

exit 0
