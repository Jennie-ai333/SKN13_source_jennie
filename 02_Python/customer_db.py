# 옆에 파일 생김 


#########
# SQL 실행 코드 함수화
#########


# 모듈이 될 때는 #임포트 해와야한다. 


from datetime import date
def select_customer_by_id(cust_id: int) -> tuple|None:  # 파라미터로 받은 커스터머 아이디를 받음 밑에에ㅔㅔㅔㅔ 
    """
    고객 id로 고객정보를 DB에서 조회해서 반환하는 함수
    Args:
    Returns:
        tuple: 조회결과
        None: 조회결과가 없을 경우
    Raises:
    """

    sql = "select * from customer where id =%s"
    with pymysql.connect(host="127.0.0.1", port=3306, user='dukecaboom', password='12345678', db='mydb') as conn:
        with conn.cursor()as cursor:
            result = cursor.execute(sql, [cust_id]) # 여기에 !!!!! 
            return cursor.fetchone()



def select_all_customer():
    """
    전체 고객정보를 조회하는 함수
    select * from customer;
    """
    pass




def update_customer(cust_id:int, name:str, email:str, tall:float, birthday:date|str) -> int:

    sql = (" update customer "
           " set name = %s, email = %s, tall = %s, birthday = %s " 
           " where id = %s ")
    with pymysql.connect(host="127.0.0.1", port=3306, user='dukecaboom', password='12345678', db='mydb') as conn:
        with conn.cursor()as cursor:
            result = cursor.execute(sql, (name, email, tall, birthday, cust_id))
            conn.commit()    # 커밋을 빼먹으면 안바뀐다ㅏ. 연결해줘야함. 
            return result



