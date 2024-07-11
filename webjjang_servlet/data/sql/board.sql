
DROP SEQUENCE board_reply_seq;



CREATE SEQUENCE board_reply_seq;



DROP SEQUENCE board_seq;



CREATE SEQUENCE board_seq;



DROP TABLE board_reply CASCADE CONSTRAINTS;



DROP TABLE board CASCADE CONSTRAINTS;



CREATE TABLE board
(
	no                    NUMBER  NOT NULL ,
	title                 VARCHAR2(300)  NOT NULL ,
	content               VARCHAR2(2000)  NOT NULL ,
	writer                VARCHAR2(30)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	pw                    VARCHAR2(30)  NOT NULL ,
	hit                   NUMBER   DEFAULT  0 NULL ,
CONSTRAINT  XPK일반_게시판 PRIMARY KEY (no)
);



CREATE TABLE board_reply
(
	rno                   NUMBER  NOT NULL ,
	no                    NUMBER  NULL ,
	content               VARCHAR2(1500)  NULL ,
	writer                VARCHAR2(30)  NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	pw                    VARCHAR2(30)  NULL ,
CONSTRAINT  XPK일반게시판_댓글 PRIMARY KEY (rno),
CONSTRAINT  R_1 FOREIGN KEY (no) REFERENCES board(no) ON DELETE CASCADE
);


