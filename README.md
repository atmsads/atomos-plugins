# ion-execs — ION 팀장 Claude Code plugin marketplace

팀장별 고정 업무 환경을 Claude Code plugin으로 묶어 내부 marketplace로 배포한다. 각 팀장은 자신의 업무 도메인에 맞춘 plugin만 설치하면 동일한 Claude Code 환경을 즉시 사용할 수 있다.

## 구조

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json          # 내부 marketplace 정의
└── plugins/
    ├── exec-base/                # 팀장 공통 환경 (베이스)
    │   ├── .claude-plugin/plugin.json
    │   ├── CLAUDE.md
    │   ├── agents/
    │   ├── hooks/
    │   └── commands/
    └── exec-marketing/           # 마케팅팀장 (ATMS MCP 연동) — 파일럿
        ├── .claude-plugin/plugin.json
        ├── CLAUDE.md
        ├── agents/
        ├── hooks/
        ├── commands/
        └── skills/
```

- `exec-base`: 모든 팀장 공통 원칙, 브리핑 포맷, 공통 agents/commands.
- `exec-<team>`: 팀별 override. 도메인 지식, MCP 연동, 전용 agents/skills.

## 파일럿 범위
- **마케팅팀장** (`exec-marketing`): ATMS MCP 기반 광고 운영·진단·리포팅.
- 이후 `exec-sales`, `exec-product` 등으로 확장.

## 팀장 온보딩 절차

### 1) 내부 marketplace 등록 (최초 1회)
Claude Code에서 아래 슬래시 커맨드 실행:

```
/plugin marketplace add <이 레포지토리 git URL 또는 로컬 경로>
```

예:
```
/plugin marketplace add git@github.com:ion-internal/claude-plugins.git
/plugin marketplace add ~/Developer/ION/claude-plugins
```

### 2) 공통 베이스 설치
```
/plugin install exec-base@ion-execs
```

### 3) 팀별 plugin 설치
마케팅팀장:
```
/plugin install exec-marketing@ion-execs
```

### 4) 업데이트
```
/plugin marketplace update ion-execs
/plugin update exec-marketing@ion-execs
```

## 개발 가이드
- 새 팀 plugin 추가 시 `plugins/exec-<team>/` 디렉토리를 만들고 `.claude-plugin/plugin.json`을 작성한 뒤 루트 `marketplace.json`의 `plugins` 배열에 항목을 추가한다.
- 베이스에 해당하는 기능은 `exec-base`에 두고, 팀 고유 override만 팀 plugin에 둔다.
- MCP 서버 연동은 각 팀장 Claude Code 설정(`settings.json`)에서 관리하며, plugin은 그 전제를 문서화한다.
