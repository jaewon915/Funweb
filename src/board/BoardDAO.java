package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection getConnection()throws Exception{
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
//		String dbId="jspid";
//		String dbPass="jsppass";
//		Connection con=null;
//		//1단계 드라이버 로더
//		Class.forName("com.mysql.jdbc.Driver");
//		//2단계 디비연결
//		con=DriverManager.getConnection(dbUrl, dbId, dbPass);
//		return con;
		
		
		// 커넥션 풀(Connection Pool)
		// 데이터베이스와 연결된 Connection 객체를 미리 생성하여
		// 풀(Pool)속에 저장해 두고 필요할때마다 이풀을 접근하여 Connection객체 사용
		// 작업이 끝나면 다시 반환
		
		// 자카르타 DBCP API 이용한 커넥션 풀
		// http://commons.apache.org
		// WebContent - WEB INF - lib
		// commons-collections-3.2.1.jar
		// commons-dbcp-1.4.jar
		// commons-pool=1.6.jar
		
		// 1. WebContent - META-INF - context.xml 만들기
		//	1단계, 2단계 기술 -> 디비연동 이름정의
		// 2. WebContent - WEB_INF - web.xml 수정
		// context.xml에 디비연동 해놓은 이름을 모든 페이지에 알려줌
		// 3. DB작업(DAO) - 이름을 불러서 사용
		
		Connection con = null;
		// Context 객체생성
		Context init=new InitialContext(); 
		// DataSource=디비연동 이름 불러오기
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
		// con = DataSource
		con=ds.getConnection();
		return con;
		
	}//getConnection class
	
	// 전체 글의 개수 구하기 getBoardCount()----------------------------------------------------------------
	public int getBoardCount(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from board";
			pstmt=con.prepareStatement(sql);
			//4. rs 실행저장
			rs = pstmt.executeQuery();
			//5. rs 데이터 있으면 count 저장
			if(rs.next()){
				count = rs.getInt(1);
				System.out.println("count : "+count);
			}
		}
		catch(Exception e){e.printStackTrace();}
		finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return count;
	}//getBoardCount class


	// 전체 글의 개수 구하기 getBoardCount()-(검색가능한 게시판)---------------------------------------------------
	public int getBoardCount(String search){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from board where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%"); //  '%검색어%'  // 작은 따옴표가 포함되어 있음
			//4. rs 실행저장
			rs = pstmt.executeQuery();
			//5. rs 데이터 있으면 count 저장
			if(rs.next()){
				count = rs.getInt(1);
				System.out.println("count : "+count);
			}
		}
		catch(Exception e){e.printStackTrace();}
		finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return count;
	}//getBoardCount class
	
	
	//게시판 페이지 가져오기----------------------------------------------------------------------------
	public List<BoardBean> getBoardList(int startRow, int pageSize){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		BoardBean bb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			// 원하는 만큼 자르기 limit  startRow-1부터 pageSize 개수만큼 가져오기
			//3단계 sql 
			sql="select * from board order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1); //시작행 -1
			pstmt.setInt(2, pageSize); //몇개글
			
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 BoardBean bb
			// bb num변수 <= rs "num"열 저장
			// boardList 한칸 저장 <= BoardBean bb 담긴 하나의 글
			while(rs.next()){ //첫행 데이터 있으면  true

				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				//boardList 한칸 저장
				boardList.add(bb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return boardList;
	} //getBoardList class

	
	//게시판 페이지 가져오기 (검색가능한 게시판)----------------------------------------------------------
	public List<BoardBean> getBoardList(int startRow, int pageSize,String search){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		BoardBean bb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			// 원하는 만큼 자르기 limit  startRow-1부터 pageSize 개수만큼 가져오기
			//3단계 sql 
			sql="select * from board where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			
			
			pstmt.setString(1, "%"+search+"%"); //몇개글
			pstmt.setInt(2, startRow-1); //시작행 -1
			pstmt.setInt(3, pageSize); //몇개글
			
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 BoardBean bb
			// bb num변수 <= rs "num"열 저장
			// boardList 한칸 저장 <= BoardBean bb 담긴 하나의 글
			while(rs.next()){ //첫행 데이터 있으면  true

				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				//boardList 한칸 저장
				boardList.add(bb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return boardList;
	} //getBoardList class

	
	//글쓰기(insert)메서드----------------------------------------------------------------	
	public void insertBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int num=0;
		
		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// num 게시판 글번호 구하기
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}
			System.out.println("num= "+num);
			
			//3. sql insert   디비날짜 now()
			sql="insert into board(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file) values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번째 물음표 1, num에 입력될 값
			pstmt.setString(2, bb.getName()); //두번째 물음표2, name에 입력될 값
			pstmt.setString(3, bb.getPass()); //세번째 물음표3, pass에 입력될 값
			pstmt.setString(4, bb.getSubject()); //다섯번째 물음표4, subject에 입력될 값
			pstmt.setString(5, bb.getContent()); //여섯번째 물음표5, content에 입력될 값
			pstmt.setInt(6, bb.getReadcount()); //일곱번째 물음표6, readcount에 입력될 값  (조회수)
			pstmt.setInt(7, num); //일곱번째 물음표7, re_ref에 입력될 값  (답변글 그룹 ==일반글의  글번호 동일)
			pstmt.setInt(8, 0); //일곱번째 물음표8, re_lev에 입력될 값  (답변글 들여쓰기, 일반글 들여쓰기 없음)
			pstmt.setInt(9, 0); //일곱번째 물음표9, re_seq에 입력될 값  (답변글 순서 일반글 순서 맨위)
			pstmt.setString(10, bb.getIp()); //일곱번째 물음표10, ip에 입력될 값
			pstmt.setString(11, bb.getFile()); //일곱번째 물음표11, file에 입력될 값
			//4. 실행
			pstmt.executeUpdate(); // insert, update, delete
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
	}// insertBoard(bb)
	
	
	
	// 게시판 내용물 가져오기---getBoard(num)--------------------------------------------------
	public BoardBean getBoard(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		BoardBean bb=null;  //선언
		
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql num에 해당하는 board 모든정보 가져오기
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select			
			//5단계 rs 첫번째 행 이동했을때 데이터 있으면
			//		자바빈 bb 객체생성
			//		bb set 메서드 멤버변수 저장 <= rs 열내용
			if(rs.next()){
				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("Re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return bb;
	}//getBoard()
	
	
	//updateBoard class ------------------------------------------------------------
	public int updateBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=-1;
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql 객체 생성 num에 해당하는  pass가져오기
			sql="select pass from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4단계 실행
			rs=pstmt.executeQuery();
			//5단계 실행 첫행으로 이동 데이터 있으면 
			if(rs.next()){
				//
				if(bb.getPass().equals(rs.getString("pass"))){
			//		비밀번호 비교 맞으면 check=1
					
			//				//3. sql 생성 num해당하는 name, subject, content수정
					sql="update board set name=?,subject=?,content=? where num=?";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setInt(4, bb.getNum());
			//4단계 실행
					pstmt.executeUpdate();
					check=1;
				}else{
			//				틀리면 check=0
					check=0;
				}
			}
			else{
				check=-1;
			}

			//				없으면 "아이디 없음" check=-1
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return check;
	}//updateBoard class
	
	
	//게시물 삭제 ------------------------------------------------------------------------	
	public int deleteBoard(int num, String pass){
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=-1;
		
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql num 조건에 해당하는  pass가져오기
			sql="select pass from board where num=?";
			pstmt=con.prepareStatement(sql);

			pstmt.setInt(1, num);
			//4단계 rs=실행 
			rs=pstmt.executeQuery();
			//5 rs 첫행 데이터 있으면 비밀번호 비교 맞으면 check=1
			if(rs.next()){
				//아이디 있음
				if(pass.equals(rs.getString("pass"))){
					//				//3. sql 생성 num해당하는 정보삭제
					sql="delete from board where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);
					//4단계 실행
					pstmt.executeUpdate();

					check=1;
				}else{
					check=0;//비밀번호 틀림
				}
			}else{
				check=-1;//아이디 없음
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return check;
	}//deleteBoard class

	
	//reInsertBoard(bb)----------------------------------------------------------------
	public void reInsertBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int num=0;
		
		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			//3. sql select 최대 num 게시판 글번호 구하기
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			//4. rs=실행저장
			rs=pstmt.executeQuery();
			//5. rs 데이터 있으면 num = 1번째열을 가져와서 +1
			if(rs.next()){
				num=rs.getInt(1)+1; // rs 1번열 데이터에 +1
			}
			System.out.println("num= "+num);
			
			// 답글순서 재배치
			//3. update 조건 : re_ref 같은그룹, re_seq 기존값보다 큰값이 있으면
			// 순서 바꾸기 re_seq 1증가
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			//4 실행
			pstmt.executeUpdate(); // insert, update, delete
			
			//3 sql insert   num구한값   re_ref 그대로
			//               re_lev+1   re_seq+1
			sql="insert into board(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file) values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번째 물음표 1, num에 입력될 값
			pstmt.setString(2, bb.getName()); //두번째 물음표2, name에 입력될 값
			pstmt.setString(3, bb.getPass()); //세번째 물음표3, pass에 입력될 값
			pstmt.setString(4, bb.getSubject()); //다섯번째 물음표4, subject에 입력될 값
			pstmt.setString(5, bb.getContent()); //여섯번째 물음표5, content에 입력될 값
			pstmt.setInt(6, 0); //일곱번째 물음표6, readcount에 입력될 값  (조회수)0
			pstmt.setInt(7, bb.getRe_ref()); //일곱번째 물음표7, re_ref 기존글  그룹번호 같게 함
			pstmt.setInt(8, bb.getRe_lev()+1); //일곱번째 물음표8, re_lev 답변글 들여쓰기 기존글+1
			pstmt.setInt(9, bb.getRe_seq()+1); //일곱번째 물음표9, re_seq 답변글  순서 기존글+1
			pstmt.setString(10, bb.getIp()); //일곱번째 물음표10, ip에 입력될 값
			pstmt.setString(11, bb.getFile()); //일곱번째 물음표11, file에 입력될 값
			//4. 실행
			pstmt.executeUpdate(); // insert, update, delete
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
	}// reInsertBoard() class
	
	
	//조회수 증가시키기 -------------------------------------------------------------------
	public void updateReadcount(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql 객체생성
			// readcount 1증가 update readcount=readcount+1 
			sql="update board set readcount=readcount+1  where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계  rs 실행결과 저장
			pstmt.executeUpdate(); // insert, update, delete
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}

	}  //updateReadcount class

	
	
	//fupdateBoard class ------------------------------------------------------------
	public int fupdateBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=-1;
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql 객체 생성 num에 해당하는  pass가져오기
			sql="select pass from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			//4단계 실행
			rs=pstmt.executeQuery();
			//5단계 실행 첫행으로 이동 데이터 있으면 
			if(rs.next()){
				//
				if(bb.getPass().equals(rs.getString("pass"))){
			//		비밀번호 비교 맞으면 check=1
					
			//				//3. sql 생성 num해당하는 name, subject, content수정
					sql="update board set name=?,subject=?,content=?, file=? where num=?";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setString(4, bb.getFile());
					pstmt.setInt(5, bb.getNum());
					
			//4단계 실행
					pstmt.executeUpdate();
					check=1;
				}else{
			//				틀리면 check=0
					check=0;
				}
			}
			else{
				check=-1;
			}

			//				없으면 "아이디 없음" check=-1
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return check;
	}//fupdateBoard class

	
}//BoardDAO class
