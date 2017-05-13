package board_re;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Board_reDAO {
	private Connection getConnection()throws Exception{
	
	Connection con = null;
	// Context 객체생성
	Context init=new InitialContext(); 
	// DataSource=디비연동 이름 불러오기
	DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
	// con = DataSource
	con=ds.getConnection();
	return con;
	}
	
	
	//회원가입할 기능(insert)메서드----------------------------------------------------------------	
	public void insertBoard_re(Board_reBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int num=0;
		
		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();
			// num 게시판 글번호 구하기
			sql="select max(num) from board_re";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}
			System.out.println("num= "+num);
			
			//3. sql insert   디비날짜 now()
			sql="insert into board_re(num, name, pass, subject, content, readcount, re_ref, re_seq, date, file) values(?, ?, ?, ?, ?, ?, ?, ?, now(),?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num); //첫번째 물음표 1, num에 입력될 값
			pstmt.setString(2, bb.getName()); //두번째 물음표2, name에 입력될 값
			pstmt.setString(3, bb.getPass()); //세번째 물음표3, pass에 입력될 값
			pstmt.setString(4, bb.getSubject()); //다섯번째 물음표4, subject에 입력될 값
			pstmt.setString(5, bb.getContent()); //여섯번째 물음표5, content에 입력될 값
			pstmt.setInt(6, bb.getReadcount()); //일곱번째 물음표6, readcount에 입력될 값  (조회수)
			pstmt.setInt(7, num); //일곱번째 물음표7, re_ref에 입력될 값  (답변글 그룹 ==일반글의  글번호 동일)
			pstmt.setInt(8, 0); //일곱번째 물음표8, re_seq에 입력될 값  (답변글 순서 일반글 순서 맨위)
			pstmt.setString(9, bb.getFile()); //일곱번째 물음표9, file 이름

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
	}// insertBoard_re(bb)
	
	
	//게시판 페이지 가져오기----------------------------------------------------------------------------
	public List getBoard_reList(int startRow, int pageSize){
		List board_reList=new ArrayList();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Board_reBean bb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			
			// sql : select * from board
			// 최근글 위로 re_ref 그룹별 내림차순 정렬   re_seq오름차순
			//		re_ref desc, re_seq asc
			// 글잘라오기 limit  시작행-1, 개수
			//3단계 sql 
			sql="select * from board_re order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1); //시작행 -1
			pstmt.setInt(2, pageSize); //몇개글
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select
			//5 rs while 데이터 있으면
			// 자바빈 객체 생성 Board_reBean bb
			// bb 멤버변수 <= rs열데이터 가져와서 저장
			// bb 게시판 글 하나 => board_reList 한칸 저장
			while(rs.next()){ //첫행 데이터 있으면  true

				bb=new Board_reBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				//board_reList 한칸 저장
				board_reList.add(bb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return board_reList;
	} //getBoard_reList()
	
	
	// 전체 글의 개수 구하기 getBoard_reCount()----------------------------------------------------------------
	public int getBoard_reCount(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int count=0;

		try{
			//1, 2 디비연결 메서드 호출
			con=getConnection();	
			//3. sql함수 count(*) 구하기
			sql = "select count(*) from board_re";
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
	}//getBoard_reCount()
	
	
	
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
			sql="update board_re set readcount=readcount+1  where num=?";
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
	public Board_reBean getBoard_re(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		Board_reBean bb=null;  //선언
		
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql num에 해당하는 board 모든정보 가져오기
			sql="select * from board_re where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select			
			//5단계 rs 첫번째 행 이동했을때 데이터 있으면
			//		자바빈 bb 객체생성
			//		bb set 메서드 멤버변수 저장 <= rs 열내용
			if(rs.next()){
				bb=new Board_reBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
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
	}//getBoard_re()
	
	
} // Board_reDAO class
