---
description: exec-content-marketing 1회 셋업 — /draft-storyboard 가 권한 프롬프트 없이 동작하도록 사용자 글로벌 settings 에 도구 허용 추가. 설치 직후 한 번만 실행.
argument-hint: "(인자 없음)"
---

# exec-content-marketing 셋업

본 커맨드는 `/draft-storyboard` 와 그 서브에이전트(`brand-researcher`, `competitor-landscape`)가 매번 도구 호출마다 사용자 승인을 묻지 않도록, **사용자 글로벌 settings**(`~/.claude/settings.json`) 의 `permissions.allow` 에 다음 도구를 추가한다.

추가할 권한 (4종):
- `WebSearch` — 리서치 검색 (Google·네이버 SERP 등)
- `WebFetch` — 공식몰·뉴스·블로그 등 외부 페이지 수집
- `Task` — 서브에이전트(`brand-researcher`, `competitor-landscape`) 병렬 호출
- `mcp__playwright` — JS 렌더링·iframe·SPA 쇼핑몰 스크래핑

## 실행 절차

다음 절차를 정확히 한 번 수행하고 사용자에게 결과를 1단락으로 보고한다.

### 1. settings 파일 경로·존재 확인
- 경로: `~/.claude/settings.json` (글로벌, 모든 프로젝트에 적용)
- Read 도구로 시도.
- 파일 없음 → 신규 생성 (Write 도구). 골격:
  ```json
  {
    "permissions": {
      "allow": [
        "WebSearch",
        "WebFetch",
        "Task",
        "mcp__playwright"
      ]
    }
  }
  ```
- 파일 있음 → 다음 단계로.

### 2. 기존 settings 파싱 + 멱등 머지
- 기존 JSON 을 안전하게 파싱. 깨져 있으면 **수정하지 말고** 사용자에게 보고하고 종료 ("settings.json 이 손상돼 있어 자동 수정 불가 — 직접 확인 필요").
- `permissions.allow` 배열이 없으면 신규 생성.
- 추가할 4개 항목 중 **이미 있는 것은 건너뛰고**, 없는 것만 append. 중복 항목 만들지 않는다.
- 다른 키(`hooks`, `env`, `mcpServers` 등)는 **절대 건드리지 않는다**.
- 추가 후 Write 도구로 저장. 들여쓰기는 기존 파일 스타일 유지.

### 3. 결과 보고 (1단락)
다음 형식으로 사용자에게 응답:
```
✓ exec-content-marketing 셋업 완료

추가된 권한 (~/.claude/settings.json):
- WebSearch (이미 있음 / 신규)
- WebFetch (이미 있음 / 신규)
- Task (이미 있음 / 신규)
- mcp__playwright (이미 있음 / 신규)

이제 /draft-storyboard 호출 시 도구 승인 프롬프트 없이 진행됩니다.
권한 되돌리기: ~/.claude/settings.json 에서 위 항목 직접 제거.
```

## 안전 규약

- **다른 settings 키 보존**: `hooks`, `env`, `mcpServers`, `permissions.deny` 등 어떤 기존 항목도 수정하지 않는다.
- **JSON 손상 시 중단**: 파싱 실패 시 자동 복구 시도하지 말고 사용자에게 보고.
- **권한 범위 한정**: 위 4종 외의 권한은 추가하지 않는다 (Bash, Edit, Write 등 임의 추가 금지).
- **본 커맨드는 멱등**: 반복 실행해도 같은 결과. 새 권한 안 박힘.
- **삭제 동작 없음**: 본 커맨드는 권한 추가만. 제거는 사용자가 직접 수행.

## 적용 범위 안내

이 셋업은 **사용자 본인의 모든 Claude Code 세션**에 적용된다 (글로벌 settings). 특정 프로젝트만 제한하려면 본 커맨드 대신 해당 프로젝트의 `.claude/settings.local.json` 을 직접 편집할 것.

`WebFetch` 는 도메인 무관 전체 허용으로 설정된다. 이유: 리서치 단계에서 동적으로 새 도메인(자사몰·SSG·쿠팡·네이버 블로그 등 케이스마다 다름) 에 접근하므로 도메인 화이트리스트는 비현실적.
