
CREATE TABLE shortened_links (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code VARCHAR(8) NOT NULL UNIQUE,
    original_url VARCHAR(2048) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,

    CONSTRAINT chk_code_length
        CHECK (LENGTH(code) BETWEEN 6 AND 8),

    CONSTRAINT chk_original_url_length
        CHECK (LENGTH(original_url) BETWEEN 1 AND 2048)
);

CREATE TABLE click_events (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    link_id BIGINT NOT NULL,
    referrer VARCHAR(2048),
    clicked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_click_events_link
        FOREIGN KEY (link_id)
        REFERENCES shortened_links(id)
);

CREATE INDEX idx_shortened_links_code
    ON shortened_links(code);

CREATE INDEX idx_click_events_link_id
    ON click_events(link_id);

CREATE INDEX idx_click_events_clicked_at
    ON click_events(clicked_at);

CREATE INDEX idx_click_events_link_clicked
    ON click_events(link_id, clicked_at);
