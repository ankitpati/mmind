drop database if exists mmind;
create database mmind character set utf8mb4 collate utf8mb4_unicode_ci;
use mmind;

create table config (
    cfgkey char(100) primary key,
    cfgval char(255) not null
);

create table roles (
    id   integer   primary key,
    name char(100) not null
);

create table users (
    id       integer   primary key auto_increment,
    realname char(255) not null,
    phone    char( 20) not null,
    email    char(100) not null,
    password char(255) not null,
    role_id  integer   not null,

    foreign key (role_id) references roles(id) on delete cascade
);

create table responses (
    user_id  integer not null,
    month    tinyint not null,
    turnover integer not null,
    is_ack   boolean not null,

    primary key (user_id, month),
    foreign key (user_id) references users(id) on delete cascade
);

create table response_lines (
    response_line_id integer  primary key auto_increment,
    user_id          integer  not null,
    month            tinyint  not null,
    hsn_code         char(20) not null,
    sales            integer  not null,
    purchase         integer  not null,
    trade_margin     integer  not null,

    foreign key (user_id, month) references responses(user_id, month)
        on delete cascade
);

create table received_texts (
    id          integer  primary key auto_increment,
    phone       char(20) not null,
    recwhen     datetime not null,
    body        text     not null,

    /* foreign key (user_id, month), but used only for joining */
    user_id     integer  not null,
    month       tinyint  not null,

    foreign key (user_id) references users(id) on delete cascade
);

create table received_emails (
    id          integer   primary key auto_increment,
    email       char(100) not null,
    recwhen     datetime  not null,
    body        text      not null,

    /* foreign key (user_id, month), but used only for joining */
    user_id     integer   not null,
    month       tinyint   not null,

    foreign key (user_id) references users(id) on delete cascade
);

create table received_posts (
    id          integer  primary key auto_increment,
    ip_address  char(50) not null, /* for IPv6 */
    recwhen     datetime not null,

    user_id     integer   not null,
    month       tinyint   not null,

    foreign key (user_id)        references users(id)
        on delete cascade,
    foreign key (user_id, month) references responses(user_id, month)
        on delete cascade
);

create table language (
    state char(50) primary key,
    lang  char(10) not null
);

create table localised_messages (
    lang char(10) not null,
    description char(100) not null,
    message text not null,

    primary key (lang, description)
);

create table businesses (
    gstin   char(20) primary key,
    user_id integer  not null,
    state   char(50) not null,

    foreign key (user_id) references users(id)       on delete cascade,
    foreign key (state)   references language(state) on delete cascade
);
