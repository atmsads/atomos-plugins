# ion-execs 설치 가이드

ION 내부 Claude Code plugin marketplace(`ion-execs`)를 신규 장비의 Claude Code 에 등록하고, 팀장별 plugin 을 배포하는 절차. 본 문서는 **플랫폼 담당자 / 신규 팀장 온보딩 담당자** 가 팀장 장비 셋업 시 참고하는 표준 절차이다.

> marketplace **이름**은 `ion-execs`, **GitHub 경로**는 `atmsads/atomos-plugins`. 설치 명령은 항상 `<plugin>@ion-execs` 형태로 참조한다.

---

## 1. 사전 준비물

- **Claude Code CLI** 설치 및 로그인 완료 (`claude` 커맨드 사용 가능 상태).
- **네트워크에서 `github.com` 에 접근 가능**. 레포 `atmsads/atomos-plugins` 는 **public** 이므로 GitHub 계정·토큰·SSO 승인은 불필요. 익명 clone 으로 동작한다.
- **(마케팅팀장 대상자만)** ATMS MCP 접근 권한 및 엔드포인트 정보. plugin 자체는 MCP 를 포함하지 않으므로 별도 설정 필요 (§4).

---

## 2. marketplace 등록

Claude Code 세션 안에서 아래 슬래시 커맨드 중 **한 가지** 를 실행한다. 세 방식 모두 같은 `ion-execs` marketplace 를 가리킨다.

**(a) GitHub `owner/repo` 축약형 — 권장 기본값**

```
/plugin marketplace add atmsads/atomos-plugins
```

**(b) HTTPS URL — (a) 와 동등, 명시적 표기**

```
/plugin marketplace add https://github.com/atmsads/atomos-plugins.git
```

(a)(b) 모두 **익명 HTTPS clone** 이므로 GitHub 계정이 없어도 된다.

**(c) SSH URL — 개발자 장비에 이미 SSH 키가 구성된 경우에만**

```
/plugin marketplace add git@github.com:atmsads/atomos-plugins.git
```

레포가 public 이어도 SSH 표기는 `git@` 인증을 요구하므로, 일반 팀장 온보딩에서는 (a) 를 쓰고 SSH 는 권장하지 않는다.

**(d) 로컬 clone 경로 — plugin 개발/디버깅용**

```
/plugin marketplace add /absolute/path/to/claude-plugins
```

등록 성공 시 marketplace 목록에 `ion-execs` 가 나타난다 (`/plugin marketplace list` 로 확인).

---

## 3. plugin 설치 절차

**반드시 `exec-base` 를 먼저 설치**한다. 팀별 plugin(`exec-marketing` 등) 은 `exec-base` 의 공통 원칙·agents·hooks 를 전제로 동작하기 때문이다.

```
/plugin install exec-base@ion-execs
```

이후 팀장 역할에 맞춰 팀별 plugin 을 설치한다. 현재 파일럿은 마케팅팀장만 제공.

```
/plugin install exec-marketing@ion-execs
```

향후 `exec-sales`, `exec-product` 등이 추가되면 동일한 `<name>@ion-execs` 패턴으로 설치한다.

---

## 4. MCP 연결 (필요한 팀장만)

**중요**: `ion-execs` plugin 은 MCP 서버를 포함·번들하지 않는다. MCP 는 팀장 장비의 Claude Code 설정에서 별도로 붙여야 한다.

설정 위치 두 가지 중 선택:

- 사용자 전역: `~/.claude/settings.json`
- 특정 프로젝트 한정: `<project>/.claude/settings.json`

마케팅팀장 ATMS MCP 예시 스니펫 (엔드포인트/토큰은 실제 값으로 교체):

```json
{
  "mcpServers": {
    "atms": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "<ATMS_MCP_ENDPOINT>"],
      "env": {
        "ATMS_API_TOKEN": "<TOKEN>"
      }
    }
  }
}
```

> `<ATMS_MCP_ENDPOINT>` 는 placeholder 이다. 실제 서버 주소와 인증 방식은 플랫폼팀이 배포하는 값을 그대로 쓰고, 이 문서에서는 임의로 가정하지 않는다. 연결 방식이 stdio/HTTP 중 무엇인지, 토큰이 env 인지 header 인지는 실제 ATMS MCP 배포 스펙을 따른다.

설정 반영을 위해 Claude Code 를 재시작한 뒤 `/mcp` 로 서버 상태를 확인한다.

---

## 5. 선택 설정 — 세션 로그 동기화

`exec-base` 는 `SessionEnd` 훅으로 세션 transcript 를 팀 공용 저장소에 동기화할 수 있다. 경로는 환경변수 `EXEC_LOG_TARGET` 로 주입하며, **미설정 시 훅은 조용히 종료**(no-op)된다.

```bash
# 원격 rsync 대상
export EXEC_LOG_TARGET="user@log-host:/srv/exec-logs/marketing/"

# 또는 로컬 마운트
export EXEC_LOG_TARGET="/Volumes/ion-exec-logs/marketing/"
```

팀장의 셸 초기화 파일(`~/.zshrc` 등)에 추가해두면 모든 세션에 적용된다.

---

## 6. 업데이트 / 제거

marketplace 메타데이터 갱신 후 원하는 plugin 만 업데이트한다.

```
/plugin marketplace update ion-execs
/plugin update exec-base@ion-execs
/plugin update exec-marketing@ion-execs
```

제거:

```
/plugin uninstall exec-marketing@ion-execs
/plugin uninstall exec-base@ion-execs
/plugin marketplace remove ion-execs
```

---

## 7. 설치 검증

설치 직후 아래 세 가지를 확인하면 정상 구동 상태이다.

1. `/plugin list` — `exec-base`, 그리고 설치한 팀 plugin 이 **enabled** 로 표시.
2. 슬래시 커맨드 자동완성 — 마케팅팀장의 경우 `/daily-brief`, `/diagnose-campaign` 등이 보여야 한다.
3. (마케팅팀장) `/mcp` 에서 ATMS 서버가 `connected` 상태. ATMS 도구(`ad_lookup` 등) 호출이 성공해야 한다.

---

## 8. 트러블슈팅

**plugin 이 안 보일 때**
- `/plugin marketplace list` 로 `ion-execs` 등록 여부 확인. 없으면 §2 재실행.
- 네트워크에서 `github.com` 접근 가능한지 확인 (`curl -I https://github.com/atmsads/atomos-plugins` → 200). 사내 방화벽/프록시가 github 도메인을 막으면 clone 실패. 레포는 public 이라 계정·토큰은 무관.
- SSH 방식(§2-c) 으로 등록했는데 실패하면 (a) HTTPS 축약형으로 재시도 — 익명으로 동작한다.
- `/plugin marketplace update ion-execs` 로 캐시 갱신 후 재시도.

**MCP 도구 호출 실패 (마케팅팀장)**
- `/mcp` 로 서버가 `connected` 인지 확인. `failed` 상태면 §4 의 `settings.json` 문법/엔드포인트/토큰 재점검.
- Claude Code 재시작 필요 (`settings.json` 변경은 런타임 반영 안 됨).
- ATMS 서버 자체 장애일 수 있으므로 `health_check` 도구로 ping.

**훅이 실행되지 않을 때 (Permission denied 등)**
- plugin 디렉토리의 쉘 스크립트 실행 권한 확인:
  ```bash
  chmod +x ~/.claude/plugins/*/plugins/exec-base/hooks/*.sh
  ```
  (정확한 plugin 설치 경로는 `/plugin list` 출력 또는 Claude Code 문서를 따른다. 배포 환경에 따라 다를 수 있으므로 추측 경로 사용 금지.)
- `EXEC_LOG_TARGET` 미설정 상태에서 `log-sync.sh` 가 조용히 종료되는 것은 정상 동작이다.
