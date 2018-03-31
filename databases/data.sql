use mmind;

set foreign_key_checks = FALSE; /* to allow dropping old tables */

delete from config;
insert into config
values
    ('token_secret_symmetric', 'replace_this_with_real_secret'),
    ('token_algorithm', 'A128KW'),
    ('token_encryption', 'A128GCM'),
    ('token_relative_expiry_seconds', 108000),
    ('minimum_unprivileged_user_id', 100)
;

delete from roles;
insert into roles
values
    (  0, 'Admin'),
    (  1, 'National Auditor'),
    (  2, 'State Auditor'),
    (100, 'User')
;

delete from users;
insert into users
values
    (0, 'Ankit Pati', '+918805062938', 'contact@ankitpati.in',
        '$2a$08$Go8n2g1fYqQwoaf/ykH5PeXT.g7jLKo8dibk1ixD5xR650flOPzrO', 0),

    (1, 'Sharang Gupta', '+918879060707', 'sharang.gupta@sitpune.edu.in',
        '$2a$08$o0xOLBhoTNxhSbehcrEeJ.mGnQVxr4paMuWQ/56LkC84JJch4xVN2', 0),

    (2, 'Abid Ahmad', '+919921876554', 'ahmad.abid@sitpune.edu.in',
        '$2a$08$MkdKkCDgiYUK2xy6E4M2V.D0tRyZVpctFMXSW425Y36pMVyfElkRG', 1),

    (3, 'Bhumika Saini', '+917016545505', 'bhumika.saini@sitpune.edu.in',
        '$2a$08$eTN3V1dWbwpn3CrgwPKiGuQqEz8DIPDY68XVyeZNNrb8FIxwPagB2', 2),

    (4, 'Jaanvi', '+917517074501', 'jaanvi.juneja@sitpune.edu.in',
        '$2a$08$chcfzpyLjmNSmK6W5Rg.1e1Tr4/w6dyUyPwZsi1TB9uuFDYLxbHcy', 100),

    (5, 'Suchismita Banerjee', '+919764947095', 'suchismita.banerjee@sitpune.edu.in',
        '$2a$08$a8.Z1gqhO56WGMqIg8e8xugT6.IqSiJBgSRZJLcK7axsnMIEcjm7K', 100)
;

delete from languages;
insert into languages
values
    ('Punjab', 'Punjabi'),
    ('West Bengal', 'Bengali')
;

delete from businesses;
insert into businesses
values
    (1234, 4, 'Punjab'),
    (1235, 5, 'West Bengal')
;

delete from responses;
insert into responses
values
    (4, 'January', 2018, 12000),
    (5, 'February', 2018, 13000)
;

delete from response_lines;
insert into response_lines
values
    (0, 4, 'January', 2018, 12, 1200, 1000, 200),
    (1, 4, 'January', 2018, 13, 1300, 1000, 300),
    (2, 4, 'January', 2018, 14, 1400, 1000, 400),
    (3, 4, 'January', 2018, 15, 1500, 1000, 500),
    (4, 5, 'February', 2018, 1312, 12000, 10000, 2000)
;

set foreign_key_checks = TRUE;
