package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	//멤버변수
	//생성자
	//메서드(멤버함수)
	//디비연결 메서드
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
	public void insertMember(MemberBean mb){// 매개변수선언
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql 객체 생성
			sql="insert into member(id, pass, name, reg_date, age, gender, email, address, address2, zip_code, phone, mobile) values(?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId()); //첫번째 물음표 1, id에 입력될 값
			pstmt.setString(2, mb.getPass()); //두번째 물음표2, pass에 입력될 값
			pstmt.setString(3, mb.getName()); //세번째 물음표3, name에 입력될 값
			pstmt.setTimestamp(4, mb.getReg_date()); //네번째 물음표 4, reg_date에 입력될 값	
			pstmt.setInt(5, mb.getAge()); //세번째 물음표3, name에 입력될 값
			pstmt.setString(6, mb.getGender()); //세번째 물음표3, name에 입력될 값
			pstmt.setString(7, mb.getEmail()); //다섯번째 물음표5, age에 입력될 값
			pstmt.setString(8, mb.getAddress()); //여섯번째 물음표6, gender에 입력될 값
			pstmt.setString(9, mb.getAddress2()); //여섯번째 물음표6, gender에 입력될 값
			pstmt.setString(10, mb.getZip_code()); //여섯번째 물음표6, gender에 입력될 값
			pstmt.setString(11, mb.getPhone()); //일곱번째 물음표7, email에 입력될 값
			pstmt.setString(12, mb.getMobile()); //일곱번째 물음표7, email에 입력될 값
			//4단계 실행
			pstmt.executeUpdate(); // insert, update, delete
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//예외 상관없이 마무리 작업
			//객체 생성 닫기
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		
	}//insertMember메서드
	
	//아이디 비밀번호체크 메서드-------------------------------------------------------------------------
	public int idCheck(String id, String pass){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		//실행할 내용
		ResultSet rs=null;
		int check=-1;
		try{
			//1단계			//2단계
			con=getConnection();
			//3단계 sql id에 해당하는 pass 가져오기
			sql="select pass from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계 rs=실행 결과 저장
			rs=pstmt.executeQuery();
			//5단계 rs첫행이동 데이터 있으면 "아이디 있음"
			//		비밀번호비교 맞으면 check=1 틀리면 check=0
			//				      없으면 "아이디 없음" check=-1;
			if(rs.next()){
				//아이디 있음
				if(pass.equals(rs.getString("pass"))){
					check=1;//비밀번호 맞음
				}else{
					check=0;//비밀번호 틀림
				}
			}else{
				check=-1;//아이디 없음
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}

		}
		return check;
	}//idCheck메서드

	//중복 아이디 체크 메서드-------------------------------------------------------------------------
	public int joinIdCheck(String id){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		//실행할 내용
		ResultSet rs=null;
		int check=0;
		
		try{
			//1단계			//2단계
			con=getConnection();
			//3단계 sql id에 해당하는 pass 가져오기
			sql="select id from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계 rs=실행 결과 저장
			rs=pstmt.executeQuery();
			//5단계 rs첫행이동 데이터 있으면 "아이디 있음"
			//		id 비교, 중복이면 check=1 아니면 check=0

			if(rs.next()){
				check=1;//중복 id 
				}else{
					check=0;//중복 id 없음
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}

		}
		return check;

	}// joinIdCheck class
	
	
	//회원정보 가져오기----------------------------------------------------------------------------
	public MemberBean getMember(String id){ // 매개변수선언
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		MemberBean mb=null;  //선언
		try{
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql id에 해당하는 member 모든정보 가져오기
			sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계  rs 실행결과 저장
			rs = pstmt.executeQuery(); //select			
			//5단계 rs 첫번째 행 이동했을때 데이터 있으면
			//		mb 객체생성
			//		mb 안에 있는 id변수에 rs에 들어있는 "id"열을 저장
			if(rs.next()){
				mb=new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				
				mb.setAddress(rs.getString("address"));
				mb.setAddress2(rs.getString("address2"));
				mb.setZip_code(rs.getString("Zip_code"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//객체닫기
			if(rs!=null){try{rs.close();}catch(SQLException ex){}}
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return mb;
	}	//getMember() 메서드
	
	
	//회원정보 업데이트-------------------------------------------------------------------------------
	public int updateMember(MemberBean mb){ // 매개변수선언
			Connection con=null;
			PreparedStatement pstmt=null;
			String sql="";
			ResultSet rs=null;
			int check=-1;
			try{
				//예외가 발생할 것 같은 명령문
				//1단계 드라이버로더			//2단계 디비연결
				con=getConnection();
				//3단계 sql 객체 생성 id에 해당하는  pass가져오기
				sql="select pass from member where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, mb.getId());
				//4단계 실행
				rs=pstmt.executeQuery();
				//5단계 실행 첫행으로 이동 데이터 있으면 "아이디 있음"
				if(rs.next()){
					//"아이디있음"
					if(mb.getPass().equals(rs.getString("pass"))){
				//		비밀번호 비교 맞으면 check=1
						
				//				//3. sql 생성 id해당하는 name, age, gender, email수정
						sql="update member set name=?,age=?,gender=?,email=?, phone=?, mobile=?, zip_code=?, address=?, address2=? where id=?";
						pstmt=con.prepareStatement(sql);
						
						pstmt.setString(1, mb.getName());
						pstmt.setInt(2, mb.getAge());
						pstmt.setString(3, mb.getGender());
						pstmt.setString(4, mb.getEmail());
						pstmt.setString(5, mb.getPhone());
						pstmt.setString(6, mb.getMobile());
						pstmt.setString(7, mb.getZip_code());
						pstmt.setString(8, mb.getAddress());
						pstmt.setString(9, mb.getAddress2());
						pstmt.setString(10, mb.getId());
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
				if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
				if(con!=null){try{con.close();}catch(SQLException ex){}}
			}
			return check;
		}//updateMember()메서드

	
	// 회원정보 삭제------------------------------------------------------------------------------
	public int deleteMember(String id, String pass){ // 매개변수선언
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=-1;
		try{
			//예외가 발생할 것 같은 명령문
			//1단계 드라이버로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql id 조건에 해당하는  pass가져오기
			sql="select pass from member where id=?";
			pstmt=con.prepareStatement(sql);

			pstmt.setString(1, id);
			//4단계 rs=실행 
			rs=pstmt.executeQuery();
			//5 rs 첫행 데이터 있으면 비밀번호 비교 맞으면 check=1
			if(rs.next()){
				//아이디 있음
				if(pass.equals(rs.getString("pass"))){
					//				//3. sql 생성 id해당하는 정보삭제
					sql="delete from member where id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, id);
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
			if(pstmt!=null){try{pstmt.close();}catch(SQLException ex){}}
			if(con!=null){try{con.close();}catch(SQLException ex){}}
		}
		return check;
		
	} //deleteMember()메서드
	
	
}
