
DROP SEQUENCE board_reply_seq;



CREATE SEQUENCE board_reply_seq;



DROP SEQUENCE board_seq;



CREATE SEQUENCE board_seq;



DROP SEQUENCE message_seq;



CREATE SEQUENCE message_seq;



DROP SEQUENCE qna_seq;



CREATE SEQUENCE qna_seq;



DROP TABLE QnA CASCADE CONSTRAINTS;



DROP TABLE board_reply CASCADE CONSTRAINTS;



DROP TABLE board CASCADE CONSTRAINTS;



DROP TABLE message CASCADE CONSTRAINTS;



DROP TABLE member CASCADE CONSTRAINTS;



DROP TABLE grade CASCADE CONSTRAINTS;



CREATE TABLE grade
(
	gradeNo               NUMBER  NOT NULL ,
	gradeName             VARCHAR2(20)  NOT NULL ,
CONSTRAINT  XPK회원등급 PRIMARY KEY (gradeNo)
);



CREATE TABLE member
(
	id                    VARCHAR2(20)  NOT NULL ,
	pw                    VARCHAR2(20)  NOT NULL ,
	name                  VARCHAR2(30)  NOT NULL ,
	gender                VARCHAR2(6)  NOT NULL  CONSTRAINT  member_gender_ck CHECK ( gender in ('남자','여자')),
	birth                 DATE  NOT NULL ,
	tel                   VARCHAR2(13)  NULL ,
	email                 VARCHAR2(50)  NOT NULL ,
	regDate               DATE   DEFAULT  sysdate NULL ,
	conDate               DATE   DEFAULT  sysdate NULL ,
	photo                 VARCHAR2(200)  NULL ,
	status                VARCHAR2(6)   DEFAULT  '정상' NULL  CONSTRAINT  member_status_ck CHECK (status in ('정상', '탈퇴', '휴면', '강퇴')),
	gradeNo               NUMBER   DEFAULT  1 NULL ,
	newMsgCnt             Number   DEFAULT  0 NULL ,
CONSTRAINT  XPK회원 PRIMARY KEY (id),
CONSTRAINT  R_2 FOREIGN KEY (gradeNo) REFERENCES grade(gradeNo) ON DELETE SET NULL
);



CREATE TABLE message
(
	no                    number  NOT NULL ,
	acceptId              VARCHAR2(20)  NULL ,
	senderId              VARCHAR2(20)  NULL ,
	sendDate              DATE   DEFAULT  sysdate NULL ,
	acceptDate            DATE  NULL ,
	content               VARCHAR2(200)  NULL ,
CONSTRAINT  XPK메세지 PRIMARY KEY (no),
CONSTRAINT  R_12 FOREIGN KEY (acceptId) REFERENCES member(id) ON DELETE SET NULL,
CONSTRAINT  R_14 FOREIGN KEY (senderId) REFERENCES member(id) ON DELETE SET NULL
);



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



CREATE TABLE QnA
(
	no                    NUMBER  NOT NULL ,
	qno                   NUMBER  NULL ,
	title                 VARCHAR2(300)  NOT NULL ,
	content               VARCHAR2(2000)  NOT NULL ,
	writer                VARCHAR2(20)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	ordNo                 NUMBER  NULL ,
	levNo                 NUMBER  NULL ,
	parentNo              NUMBER  NULL ,
	id                    VARCHAR2(20)  NULL ,
CONSTRAINT  XPK질문_답변 PRIMARY KEY (no),
CONSTRAINT  R_15 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL,
CONSTRAINT  R_17 FOREIGN KEY (qno) REFERENCES QnA(no) ON DELETE SET NULL,
CONSTRAINT  R_18 FOREIGN KEY (parentNo) REFERENCES QnA(no) ON DELETE SET NULL
);


