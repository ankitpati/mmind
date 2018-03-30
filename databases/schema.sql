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
    id    integer primary key auto_increment,
    total integer not null
);

create table response_lines (
    response_line_id integer  primary key auto_increment,
    response_id      integer  not null,
    hsn_code         char(20) not null,
    sales            integer  not null,
    purchase         integer  not null,
    trade_margin     integer  not null,

    foreign key (response_id) references responses(id) on delete cascade
);

create table received_texts (
    id          integer  primary key auto_increment,
    user_id     integer  not null,
    phone       char(20) not null,
    recwhen     datetime not null,
    body        text     not null,
    response_id integer, /* foreign key, but used only for joining */

    foreign key (user_id) references users(id) on delete cascade
);

create table received_emails (
    id          integer   primary key auto_increment,
    user_id     integer   not null,
    email       char(100) not null,
    recwhen     datetime  not null,
    body        text      not null,
    response_id integer, /* foreign key, but used only for joining */

    foreign key (user_id) references users(id) on delete cascade
);

create table received_posts (
    id          integer  primary key auto_increment,
    user_id     integer  not null,
    ip_address  char(50) not null, /* for IPv6 */
    recwhen     datetime not null,
    response_id integer  not null,

    foreign key (user_id)     references users(id)     on delete cascade,
    foreign key (response_id) references responses(id) on delete cascade
);
