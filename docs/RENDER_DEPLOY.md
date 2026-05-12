# Render Deploy

현재 저장소는 루트 `Dockerfile` 기준으로 Render Web Service에 배포할 수 있다.

## Render 설정

- Runtime: `Docker`
- Build Context: repository root
- Dockerfile Path: `./Dockerfile`
- Health Check Path: `/api/health`

## 배포 계약

- Spring은 `PORT`가 있으면 그 값을 우선 사용한다.
- 런타임 이미지에는 Java app jar, Python 3, `collectors/`, `scripts/`, `requirements.txt`가 포함된다.
- 극장 좌표 fallback에 필요한 `frontend/src/map/theaters.json`과 bundled static map resource도 포함된다.

## 필수 환경 변수

- `DABOYEO_FRONTEND_ORIGINS=https://<render-domain>`
- `TIDB_HOST`
- `TIDB_PORT`
- `TIDB_DATABASE`
- `TIDB_USER`
- `TIDB_PASSWORD`

## 권장 운영 값

```dotenv
DABOYEO_PUBLIC_COLLECTION_ENABLED=false
DABOYEO_PUBLIC_SEAT_LAYOUT_ENABLED=false
DABOYEO_PUBLIC_NEARBY_REFRESH_ENABLED=true
DABOYEO_SYNC_PYTHON=python
```

## 참고

- 루트 `Dockerfile`은 Gradle wrapper에 의존하지 않고 `gradle bootJar`로 이미지를 빌드한다.
- Render에서 별도 start command를 넣지 않아도 Docker entrypoint로 Spring app이 기동된다.
