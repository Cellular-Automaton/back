-- header

CREATE TYPE user_role AS ENUM (
  'admin',
  'developper',
  'user'
);

CREATE TABLE IF NOT EXISTS "user" (
    "user_id" uuid UNIQUE PRIMARY KEY,
    "username" varchar(30),
    "email" varchar(50),
    "phone" varchar(15),
    "created_at" timestamp,
    "verified" boolean DEFAULT false,
    "role" user_role
);

CREATE TABLE IF NOT EXISTS "post" (
    "post_id" uuid UNIQUE PRIMARY KEY,
    "edited" boolean,
    "title" varchar(200),
    "contents" varchar(500),
    "posted_by" uuid,
    "viewed_by" uuid,
    "liked_by" uuid,
    "disliked_by" uuid,
    CONSTRAINT post_posted_fkey FOREIGN KEY (posted_by)
        REFERENCES "user"(user_id),
    CONSTRAINT post_viewed_fkey FOREIGN KEY (viewed_by)
        REFERENCES "user"(user_id),
    CONSTRAINT post_liked_fkey FOREIGN KEY (liked_by)
        REFERENCES "user"(user_id),
    CONSTRAINT post_disliked_fkey FOREIGN KEY (disliked_by)
        REFERENCES "user"(user_id)
);

CREATE TABLE IF NOT EXISTS "comment" (
    "comment_id" uuid UNIQUE PRIMARY KEY,
    "edited" boolean,
    "contents" varchar(500),
    "posted_by" uuid,
    "post_id" uuid,
    CONSTRAINT comment_user_fkey FOREIGN KEY (posted_by)
        REFERENCES "user"(user_id),
    CONSTRAINT comment_post_fkey FOREIGN KEY (post_id)
        REFERENCES post(post_id)
);

CREATE TABLE IF NOT EXISTS "automaton" (
    "automaton_id" uuid UNIQUE PRIMARY KEY,
    "posted_by" uuid,
    "contents" varchar(200),
    "name" varchar(100),
    "description" varchar,
    "viewed_by" uuid,
    CONSTRAINT automaton_user_fkey FOREIGN KEY (posted_by)
        REFERENCES "user"(user_id),
    CONSTRAINT automaton_viewed_fkey FOREIGN KEY (viewed_by)
        REFERENCES "user"(user_id)
);

CREATE TABLE IF NOT EXISTS "blocked" (
    "blocked_id" uuid UNIQUE PRIMARY KEY,
    "user_id" uuid,
    "time_unblock" timestamp,
    "blocked_at" timestamp,
    CONSTRAINT blocked_user_fkey FOREIGN KEY (user_id)
        REFERENCES "user"(user_id)
);

CREATE TABLE IF NOT EXISTS "favorite" (
    "user_id" uuid,
    "automaton_id" uuid,
    constraint favorite_pkey PRIMARY KEY(user_id, automaton_id),
    CONSTRAINT fav_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES "user"(user_id),
    CONSTRAINT fav_automaton_id_fkey FOREIGN KEY (automaton_id)
        REFERENCES automaton(automaton_id)
);
