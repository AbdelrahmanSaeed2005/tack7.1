create database  Film 
go
use Film 
go
create table actors(
	actor_id int primary key identity,
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	gender varchar(1) not null
)
create table directors(
	dir_id int primary key identity,
	f_name varchar(20) not null,
	l_name varchar(20) not null
)
create table genres(
	gen_id int primary key identity,
	gen_title varchar(20) not null
)

create table movies(
	mov_id int primary key identity,
	title varchar(50) not null,
	years int not null,
	time int not null ,
	lang varchar(50) not null,
	mov_dt_rel date not null,
	rel_country varchar(5) not null
)

create table reviewer(
	rev_id int primary key identity,
	name varchar(30) not null 
)
create table movie_direction(
	dir_id int references directors(dir_id),
	mov_id int references movies(mov_id),
	primary key (mov_id ,dir_id)
) 
create table movie_genres(
	mov_id int references movies(mov_id),
	gen_id int references genres(gen_id),
	primary key (mov_id, gen_id)
)
create table movie_cast(
	role varchar(30) ,
 	mov_id int references movies(mov_id),
	actor_id int references actors(actor_id),
	primary key (mov_id,actor_id) 
)
create table rating(
	mov_id int references movies(mov_id),
	rev_id int references reviewer(rev_id),
	primary key (mov_id, rev_id),
	rev_stars int,
	num_o_ratings int 
)