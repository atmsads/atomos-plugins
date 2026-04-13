# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This repo is a **Claude Code plugin marketplace** (`ion-execs`) — not a runtime application. It packages ION 팀장별 고정 업무 환경을 Claude Code plugin으로 배포한다. 배포 단위는 `plugins/exec-<team>/`, 엔드유저는 Claude Code CLI 에서 `/plugin install <name>@ion-execs`로 설치한다.

There is no build/test/lint toolchain. "Shipping" means editing plugin files and committing; consumers pull via `/plugin marketplace update ion-execs`.

## Architecture

Three-layer structure, each layer has a specific role — changes should respect the layer boundaries:

1. **Marketplace manifest** — `.claude-plugin/marketplace.json`
   - Single source of truth for what plugins exist and where they live.
   - Every new plugin must be added here, or it won't be installable.
   - `name` = `ion-execs` (install reference); repo lives at GitHub `atmsads/atomos-plugins`.

2. **Base plugin** — `plugins/exec-base/`
   - Common 팀장 환경: 출력 원칙 (한국어, 의사결정자 관점, 수치 + 출처), 공통 agent (`exec-briefing`), 공통 훅.
   - Every `exec-<team>` plugin assumes this is installed. 공통 동작 변경 시 여기만 고치면 전체에 반영된다.

3. **Team plugin** — `plugins/exec-<team>/` (currently only `exec-marketing`)
   - Domain override: 매체·KPI·MCP 도메인 지식 + 전용 agents/commands/skills.
   - Must not duplicate `exec-base`; only add team-specific delta.

### Plugin internal layout

```
plugins/<plugin>/
├── .claude-plugin/plugin.json   # plugin 메타 (name/version/description)
├── CLAUDE.md                    # plugin 단위 domain context — loaded at runtime
├── agents/*.md                  # subagent 정의 (frontmatter: name/description)
├── commands/*.md                # slash command 정의 (frontmatter: description/argument-hint)
├── hooks/hooks.json + *.sh      # 세션 훅 — scripts ref via ${CLAUDE_PLUGIN_ROOT}
└── skills/                      # 추후 추가
```

Agents/commands follow standard Claude Code markdown-with-frontmatter format. Hook scripts are invoked via `${CLAUDE_PLUGIN_ROOT}` so paths stay portable.

### Hooks convention (exec-base)

- `UserPromptSubmit → scope-check.sh`: 권한 외 요청 차단 지점. Exit codes matter — `0` pass, `2` block (stderr shown to user+model).
- `SessionEnd → log-sync.sh`: transcript 동기화. `EXEC_LOG_TARGET` env 미설정 시 no-op. SessionEnd 훅은 exit code가 model 동작에 영향 없음 → 실패를 흡수해 사용자 세션을 방해하지 않아야 한다.
- 두 스크립트 모두 현재 placeholder. 실제 정책 룰을 추가할 때도 위 exit-code 규약을 유지할 것.

## Conventions for edits

- **Adding a new team plugin**: `plugins/exec-<team>/` 디렉토리 생성 → `.claude-plugin/plugin.json` + `CLAUDE.md` 작성 → 루트 `marketplace.json` 의 `plugins` 배열에 entry 추가. 버전은 semver, 초기는 `0.1.0`.
- **공통 vs 팀별 경계**: 모든 팀장에게 공통이면 `exec-base`, 도메인 특화면 팀 plugin. 중복 발견 시 base 쪽으로 끌어올린다.
- **언어**: plugin CLAUDE.md / agent / command 본문은 한국어 기본 (팀장 사용자용). 전문 용어는 원문 병기.
- **MCP 연동**: plugin 자체는 MCP 서버를 포함하지 않는다. 팀장 로컬 `settings.json` 에서 MCP 를 붙이는 것이 전제이고, plugin CLAUDE.md 는 그 전제를 문서화만 한다 (예: `exec-marketing` 은 ATMS MCP 가정).
- **수치 보고 규칙** (exec-base 에서 상속): 값 + 기간 + 출처(MCP tool 명) 3종 세트 없이 수치를 쓰지 않는다. Agent/command 를 작성할 때 이 규약을 깨지 않도록 지시문에 반영.

## Install / update (for reference when helping users)

```
/plugin marketplace add atmsads/atomos-plugins   # 최초 1회
/plugin install exec-base@ion-execs
/plugin install exec-marketing@ion-execs
/plugin marketplace update ion-execs             # 업데이트
```

로컬 개발 경로로 등록하려면 `/plugin marketplace add ~/Developer/ION/claude-plugins`.
