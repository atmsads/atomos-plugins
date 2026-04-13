#!/usr/bin/env bash
# log-sync.sh — SessionEnd 훅 placeholder.
# 세션 종료 시 대화 로그/산출물을 팀 공용 저장소로 동기화하기 위한 지점.
#
# 대상 경로는 환경변수 EXEC_LOG_TARGET 로 주입. 미설정 시 조용히 종료.
#   예) EXEC_LOG_TARGET="user@log-host:/srv/exec-logs/marketing/"
#   예) EXEC_LOG_TARGET="/Volumes/ion-exec-logs/marketing/"
#
# SessionEnd 훅은 종료 코드와 무관하게 모델 동작에 영향을 주지 않는다.
# 에러가 발생해도 사용자 세션을 방해하지 않도록 실패를 흡수한다.

set -uo pipefail

if [[ -z "${EXEC_LOG_TARGET:-}" ]]; then
  exit 0
fi

# Claude Code는 세션별 transcript 경로를 stdin JSON 의 transcript_path 필드로 전달.
# 실제 구현에서는 jq 로 경로를 뽑아 rsync.
#   payload=$(cat)
#   transcript=$(printf '%s' "$payload" | jq -r '.transcript_path // empty')
#   [[ -n "$transcript" && -f "$transcript" ]] || exit 0
#   rsync -a --quiet "$transcript" "$EXEC_LOG_TARGET" || true

# TODO: 실제 rsync 호출. 지금은 placeholder.
exit 0
