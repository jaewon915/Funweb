package data_room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;





public class Data_roomDAO {

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

	
	//자료실 글 올리기 (첨부파일 추가) (insert)메서드----------------------------------------------------------------	
	public void insertData_room(Data_roomBean drb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int num=0;
		
		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// num 게시판 글번호 구하기
			sql="select max(num) from data_room";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}
			System.out.println("num= "+num);
			
			//3. sql insert   디비날짜 now()
			sql="insert into data_room(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file) values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번째 물음표 1, num에 입력될 값
			pstmt.setString(2, drb.getName()); //두번째 물음표2, name에 입력될 값
			pstmt.setString(3, drb.getPass()); //세번째 물음표3, pass에 입력될 값
			pstmt.setString(4, drb.getSubject()); //다섯번째 물음표4, subject에 입력될 값
			pstmt.setString(5, drb.getContent()); //여섯번째 물음표5, content에 입력될 값
			pstmt.setInt(6, drb.getReadcount()); //일곱번째 물음표6, readcount에 입력될 값  (조회수)
			pstmt.setInt(7, num); //일곱번째 물음표7, re_ref에 입력될 값  (답변글 그룹 ==일반글의  글번호 동일)
			pstmt.setInt(8, 0); //일곱번째 물음표8, re_lev에 입력될 값  (답변글 들여쓰기, 일반글 들여쓰기 없음)
			pstmt.setInt(9, 0); //일곱번째 물음표9, re_seq에 입력될 값  (답변글 순서 일반글 순서 맨위)
			pstmt.setString(10, drb.getIp()); //일곱번째 물음표10, ip에 입력될 값
			pstmt.setString(11, drb.getFile()); //일곱번째 물음표11, file에 입력될 값
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

	

	// 전체 자료의 개수 구하기 getData_roomCount()----------------------------------------------------------------
	public int getData_roomCount(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from data_room";
			pstmt=con.prepareStatement(sql);
			//4. rs 실행저장
			rs = pstmt.executeQuery();
			//5. rs 데이터 있으면 count 저장
			if(rs.next()){
				count = rs.getInt(1);
				System.out.println("Data_room count : "+count);
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
	}// getData_roomCount class
	
	
	// 전체 글의 개수 구하기 getData_roomCount()-(검색가능한 게시판)---------------------------------------------------
	public int getData_roomCount(String search){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from data_room where subject like ?";
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
	}//getData_roomCount class

	
	//자료실 페이지 가져오기----------------------------------------------------------------------------
	public List<Data_roomBean> getData_roomList(int startRow, int pageSize){
		List<Data_roomBean> data_roomList=new ArrayList<Data_roomBean>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Data_roomBean drb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			// 원하는 만큼 자르기 limit  startRow-1부터 pageSize 개수만큼 가져오기
			//3단계 sql 
			sql="select * from data_room order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1); //시작행 -1
			pstmt.setInt(2, pageSize); //몇개글
			
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 Data_roomBean drb
			// drb num변수 <= rs "num"열 저장
			// data_roomList 한칸 저장 <= Data_roomBean drb 담긴 하나의 글
			while(rs.next()){ //첫행 데이터 있으면  true

				drb=new Data_roomBean();
				
				drb.setNum(rs.getInt("num"));
				drb.setName(rs.getString("name"));
				drb.setPass(rs.getString("pass"));
				drb.setSubject(rs.getString("subject"));
				drb.setContent(rs.getString("content"));
				drb.setReadcount(rs.getInt("readcount"));
				drb.setRe_ref(rs.getInt("re_ref"));
				drb.setRe_lev(rs.getInt("re_lev"));
				drb.setRe_seq(rs.getInt("re_seq"));
				drb.setDate(rs.getDate("date"));
				drb.setIp(rs.getString("ip"));
				drb.setFile(rs.getString("file"));
				//boardList 한칸 저장
				data_roomList.add(drb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return data_roomList;
	} //getData_roomList class


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
			sql="update data_room set readcount=readcount+1  where num=?";
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
	
	
	// 게시판 내용물 가져오기-------------------------------------------------------------------
	public Data_roomBean getData_room(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Data_roomBean drb=null;  //선언
		
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql num에 해당하는 board 모든정보 가져오기
			sql="select * from data_room where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select			
			//5단계 rs 첫번째 행 이동했을때 데이터 있으면
			//		자바빈 bb 객체생성
			//		bb set 메서드 멤버변수 저장 <= rs 열내용
			if(rs.next()){
				drb=new Data_roomBean();
				drb.setNum(rs.getInt("num"));
				drb.setName(rs.getString("name"));
				drb.setPass(rs.getString("pass"));
				drb.setSubject(rs.getString("subject"));
				drb.setContent(rs.getString("content"));
				drb.setReadcount(rs.getInt("readcount"));
				drb.setRe_ref(rs.getInt("re_ref"));
				drb.setRe_lev(rs.getInt("Re_lev"));
				drb.setRe_seq(rs.getInt("re_seq"));
				drb.setDate(rs.getDate("date"));
				drb.setIp(rs.getString("ip"));
				drb.setFile(rs.getString("file"));
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return drb;
	}//getData_room()

	
	//자료실 페이지 가져오기 (검색가능한 자료실)----------------------------------------------------------
	public List<Data_roomBean> getData_roomList(int startRow, int pageSize,String search){
		List<Data_roomBean> data_roomList=new ArrayList<Data_roomBean>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Data_roomBean drb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			// 원하는 만큼 자르기 limit  startRow-1부터 pageSize 개수만큼 가져오기
			//3단계 sql 
			sql="select * from data_room where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			
			
			pstmt.setString(1, "%"+search+"%"); //몇개글
			pstmt.setInt(2, startRow-1); //시작행 -1
			pstmt.setInt(3, pageSize); //몇개글
			
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 Data_roomBean drb
			// drb num변수 <= rs "num"열 저장
			// data_roomList 한칸 저장 <= Data_roomBean drb 담긴 하나의 글
			while(rs.next()){ //첫행 데이터 있으면  true

				drb=new Data_roomBean();
				drb.setNum(rs.getInt("num"));
				drb.setName(rs.getString("name"));
				drb.setPass(rs.getString("pass"));
				drb.setSubject(rs.getString("subject"));
				drb.setContent(rs.getString("content"));
				drb.setReadcount(rs.getInt("readcount"));
				drb.setRe_ref(rs.getInt("re_ref"));
				drb.setRe_lev(rs.getInt("re_lev"));
				drb.setRe_seq(rs.getInt("re_seq"));
				drb.setDate(rs.getDate("date"));
				drb.setIp(rs.getString("ip"));
				drb.setFile(rs.getString("file"));
				//boardList 한칸 저장
				data_roomList.add(drb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return data_roomList;
	} //getData_roomList class
	
	
	//fupdateBoard class ------------------------------------------------------------
	public int fupdateData_room(Data_roomBean drb){
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
			sql="select pass from data_room where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, drb.getNum());
			//4단계 실행
			rs=pstmt.executeQuery();
			//5단계 실행 첫행으로 이동 데이터 있으면 
			if(rs.next()){
				//
				if(drb.getPass().equals(rs.getString("pass"))){
			//		비밀번호 비교 맞으면 check=1
					
			//				//3. sql 생성 num해당하는 name, subject, content수정
					sql="update data_room set name=?,subject=?,content=?, file=? where num=?";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, drb.getName());
					pstmt.setString(2, drb.getSubject());
					pstmt.setString(3, drb.getContent());
					pstmt.setString(4, drb.getFile());
					pstmt.setInt(5, drb.getNum());
					
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
	}//fupdateData_room class

	
	
	//자료 삭제 ------------------------------------------------------------------------	
	public int deleteData_room(int num, String pass){
		
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
			sql="select pass from data_room where num=?";
			pstmt=con.prepareStatement(sql);

			pstmt.setInt(1, num);
			//4단계 rs=실행 
			rs=pstmt.executeQuery();
			//5 rs 첫행 데이터 있으면 비밀번호 비교 맞으면 check=1
			if(rs.next()){
				//아이디 있음
				if(pass.equals(rs.getString("pass"))){
					//				//3. sql 생성 num해당하는 정보삭제
					sql="delete from data_room where num=?";
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
	}//deleteData_room class

	
	
	
} // Data_roomDAO class
