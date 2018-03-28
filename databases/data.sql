use mmind;

set foreign_key_checks = 0; /* to allow dropping old tables */

delete from config;
insert into config
values
    ('token_secret_symmetric', 'replace_this_with_real_secret'),
    ('token_algorithm', 'HS256')
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
        '$2a$08$7pqki1zZ6jr8ixt/tB/RnOhi8DQhX7fwR/VtAl96T.DqgbNTvaB9i', 1),

    (2, 'Abid Ahmad', '+919921876554', 'ahmad.abid@sitpune.edu.in',
        '$2a$08$MkdKkCDgiYUK2xy6E4M2V.D0tRyZVpctFMXSW425Y36pMVyfElkRG', 2),

    (3, 'Bhumika Saini', '+917016545505', 'bhumika.saini@sitpune.edu.in',
        '$2a$08$eTN3V1dWbwpn3CrgwPKiGuQqEz8DIPDY68XVyeZNNrb8FIxwPagB2', 2),

    (4, 'Jaanvi', '+917517074501', 'jaanvi.juneja@sitpune.edu.in',
        '$2a$08$chcfzpyLjmNSmK6W5Rg.1e1Tr4/w6dyUyPwZsi1TB9uuFDYLxbHcy', 100),

    (5, 'Suchismita Banerjee', '+919764947095', 'suchismita.banerjee@sitpune.edu.in',
        '$2a$08$a8.Z1gqhO56WGMqIg8e8xugT6.IqSiJBgSRZJLcK7axsnMIEcjm7K', 100)
;

set foreign_key_checks = 1;
