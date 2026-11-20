CREATE TABLE challenges (
    id             BIGSERIAL PRIMARY KEY,
    slug           VARCHAR(100) NOT NULL UNIQUE,
    title          VARCHAR(200) NOT NULL,
    category       VARCHAR(30) NOT NULL CHECK (
        category IN (
            'WEB',
            'CRYPTO',
            'FORENSICS',
            'REVERSE_ENGINEERING',
            'PWN',
            'OSINT',
            'MISC'
        )
    ),
    points         INTEGER NOT NULL CHECK (points > 0),
    author         VARCHAR(100),
    tags           TEXT[] NOT NULL DEFAULT '{}'::TEXT[],
    description    TEXT NOT NULL,
    flag           VARCHAR(255) NOT NULL,
    reviewer_notes TEXT,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE chellenge_hints (
    id           BIGSERIAL PRIMARY KEY,
    challenge_id BIGIN NOT NULL REFERENCES challenges (id) ON DELETE CASCADE,
    sort_order   SMALLINT NOT NULL,
    body         TEXT NOT NULL,
    claim_cost   INTEGER NOT NULL DEFAULT 0 CHECK (cost >= 0),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (challenge_id, sort_order)
);

CREATE TABLE challenge_attachments (
    id           BIGSERIAL PRIMARY KEY,
    challenge_id BIGINT NOT NULL REFERENCES challenges (id) ON DELETE CASCADE,
    filename     VARCHAR(255) NOT NULL,
    storage_key  VARCHAR(500) NOT NULL
);

CREATE TRIGGER challenges_set_updated_at
BEFORE UPDATE ON challenges
FOR EACH ROW
WHEN (old.* IS DISTINCT FROM new.*)
EXECUTE FUNCTION SET_UPDATED_AT();

CREATE TRIGGER challenge_hints_set_updated_at
BEFORE UPDATE ON challenge_hints
FOR EACH ROW
WHEN (old.* IS DISTINCT FROM new.*)
EXECUTE FUNCTION SET_UPDATED_AT();
