package board2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;



public class Board2DAO {

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
	
	
	//글쓰기(insert)메서드----------------------------------------------------------------	
	public void insertBoard2(Board2Bean b2b, int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int num2=0;
		int num3=num;
		
		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// num 게시판 글번호 구하기
			sql="select max(num2) from board2";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				num2=rs.getInt(1)+1;
			}
			System.out.println("num2= "+num2);
			
			//3. sql insert   디비날짜 now()
			sql="insert into board2(num2, name2, pass2, subject2, content2, readcount2, re_ref2, re_lev2, re_seq2, date2, ip2, file2, re_reff) values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num2); //첫번째 물음표 1, num에 입력될 값
			pstmt.setString(2, b2b.getName2()); //두번째 물음표2, name에 입력될 값
			pstmt.setString(3, b2b.getPass2()); //세번째 물음표3, pass에 입력될 값
			pstmt.setString(4, b2b.getSubject2()); //다섯번째 물음표4, subject에 입력될 값
			pstmt.setString(5, b2b.getContent2()); //여섯번째 물음표5, content에 입력될 값
			pstmt.setInt(6, b2b.getReadcount2()); //일곱번째 물음표6, readcount에 입력될 값  (조회수)
			pstmt.setInt(7, b2b.getRe_ref2()); //일곱번째 물음표7, re_ref에 입력될 값  (답변글 그룹 ==일반글의  글번호 동일)
			pstmt.setInt(8, 0); //일곱번째 물음표8, re_lev에 입력될 값  (답변글 들여쓰기, 일반글 들여쓰기 없음)
			pstmt.setInt(9, 0); //일곱번째 물음표9, re_seq에 입력될 값  (답변글 순서 일반글 순서 맨위)
			pstmt.setString(10, b2b.getIp2()); //일곱번째 물음표10, ip에 입력될 값
			pstmt.setString(11, b2b.getFile2()); //일곱번째 물음표11, file에 입력될 값
			pstmt.setInt(12, num3); //일곱번째 물음표12, re_reff에 입력될 값
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
	}// insertBoard2(b2b)
	

	// 전체 글의 개수 구하기 getBoard2Count()----------------------------------------------------------------
	public int getBoard2Count(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from board2";
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
	}//getBoard2Count class

	
	//게시판 페이지 가져오기----------------------------------------------------------------------------
	public List<Board2Bean> getBoard2List(int num){
		List<Board2Bean> board2List=new ArrayList<Board2Bean>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		Board2Bean b2b=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board2
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			// 원하는 만큼 자르기 limit  startRow-1부터 pageSize 개수만큼 가져오기
			//3단계 sql 
			//sql="select * from board2 order by num2 desc";
			sql="select b1.num, b1.name, b1.pass, b1.subject, b1.content, b1.readcount, b1.re_ref, b1.re_lev, b1.re_seq,"
					+ "b1.date, b1.ip, b1.file, b2.num2, b2.name2, b2.pass2, b2.subject2, b2.content2, b2.readcount2,"
					+ "b2.re_reff, b2.re_ref2, b2.re_lev2, b2.re_seq2, b2.date2, b2.ip2, b2.file2 from data_room b1 join board2 b2 on (b1.num = b2.re_reff)"
					+ " where b2.re_reff=? order by b2.num2 desc ";

			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			System.out.println("num : "+num);
			
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 Board2Bean b2b
			// b2b num변수 <= rs "num"열 저장
			// board2List 한칸 저장 <= BoardBean b2b 담긴 하나의 글
			while(rs.next()){ //첫행 데이터 있으면  true

				b2b=new Board2Bean();
				b2b.setNum2(rs.getInt("num2"));
				b2b.setName2(rs.getString("name2"));
				b2b.setPass2(rs.getString("pass2"));
				b2b.setSubject2(rs.getString("subject2"));
				b2b.setContent2(rs.getString("content2"));
				b2b.setReadcount2(rs.getInt("readcount2"));
				b2b.setRe_reff(rs.getInt("re_reff"));
				b2b.setRe_ref2(rs.getInt("re_ref2"));
				b2b.setRe_lev2(rs.getInt("re_lev2"));
				b2b.setRe_seq2(rs.getInt("re_seq2"));
				b2b.setDate2(rs.getDate("date2"));
				b2b.setIp2(rs.getString("ip2"));
				b2b.setFile2(rs.getString("file2"));
				//boardList 한칸 저장
				board2List.add(b2b);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return board2List;
	} //getBoard2List class

	
	
	// 게시판 내용물 가져오기---getBoard2(num)--------------------------------------------------
	public Board2Bean getBoard2(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Board2Bean b2b=null;  //선언
		
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql num에 해당하는 board 모든정보 가져오기
			sql="select * from board2 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select			
			//5단계 rs 첫번째 행 이동했을때 데이터 있으면
			//		자바빈 bb 객체생성
			//		bb set 메서드 멤버변수 저장 <= rs 열내용
			if(rs.next()){
				b2b=new Board2Bean();
				b2b.setNum2(rs.getInt("num"));
				b2b.setName2(rs.getString("name"));
				b2b.setPass2(rs.getString("pass"));
				b2b.setSubject2(rs.getString("subject"));
				b2b.setContent2(rs.getString("content"));
				b2b.setReadcount2(rs.getInt("readcount"));
				b2b.setRe_ref2(rs.getInt("re_ref"));
				b2b.setRe_lev2(rs.getInt("Re_lev"));
				b2b.setRe_seq2(rs.getInt("re_seq"));
				b2b.setDate2(rs.getDate("date"));
				b2b.setIp2(rs.getString("ip"));
				b2b.setFile2(rs.getString("file"));
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return b2b;
	}//getBoard()

	
	//updateBoard class ------------------------------------------------------------
	public int updateBoard2(Board2Bean b2b, int num2){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=-1;
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql 객체 생성 num2에 해당하는  pass가져오기
			sql="select pass2 from board2 where num2=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, b2b.getNum2());
			//4단계 실행
			rs=pstmt.executeQuery();
			//5단계 실행 첫행으로 이동 데이터 있으면 
			if(rs.next()){
				//
				if(b2b.getPass2().equals(rs.getString("pass2"))){
				//if(pass2.equals(rs.getString("pass2"))){
			//		비밀번호 비교 맞으면 check=1
					
			//				//3. sql 생성 num해당하는 name, subject, content수정
					sql="update board2 set name2=?, content2=? where num2=?";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, b2b.getName2());
					//pstmt.setString(2, b2b.getSubject2());
					pstmt.setString(2, b2b.getContent2());
					pstmt.setInt(3, b2b.getNum2());
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
	}//updateBoard2 class
	
	
	
	//댓글 삭제 ------------------------------------------------------------------------	
	public int deleteBoard2(int num2, String pass2){
		
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
			sql="select pass2 from board2 where num2=?";
			pstmt=con.prepareStatement(sql);

			pstmt.setInt(1, num2);
			//4단계 rs=실행 
			rs=pstmt.executeQuery();
			//5 rs 첫행 데이터 있으면 비밀번호 비교 맞으면 check=1
			if(rs.next()){
				//아이디 있음
				if(pass2.equals(rs.getString("pass2"))){
					//				//3. sql 생성 num해당하는 정보삭제
					sql="delete from board2 where num2=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num2);
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
	}//deleteBoard2 class
	
	
}
