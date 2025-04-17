import streamlit as st
import pandas as pd
import numpy as np

#########################################
# 사용자로 부터 입력을 받기 위한 위젯들
#########################################

# 페이지 설정
st.set_page_config(page_title="✏️Input Widget✏️", layout="wide")
## 페이지타이틀 - chrome 위 탭에 보여지는 제목.
## wide - 화면에서 중앙 배치가 아니고 전체적으로 보여지게. 
################################################################
#  값 입력 받기
################################################################
st.subheader("text 입력")
name_value = st.text_input("이름") ## 입력되어서 값이 바뀌는 것을 "event"라 한다. 
# if name_value:
st.write("이름: " + name_value) ## 특정 이벤트가 발생하면 처리해야한다. - 저장, 검색 등 
## 문제점: 화면에 입력은 하지만, 코드는 끝났다. - streamlit은 구조상, 이벤트가 발생하고 엔터를 치거나, 입력창에서 빠져나오면, 전체 스트림릿 코드를 다시 실행한다. 인풋에 입력 된 값을 화면에 보여주고 다음으로 넘어간다.  
## 비효율적, 그렇게 할 수 밖에 없는 기능...



st.subheader("여러줄 텍스트 입력") #text는 width가 필요없으니 height만 고려
info = st.text_area("정보", height=200)  #height 단위: pixcel
st.write(info.replace("\n", "<br>"), unsafe_allow_html=True)

st.subheader("Number Input")
num = st.number_input("값")
st.write("입력값:", num)  ## 문자는 입력 안되게 만들었다 

st.subheader("slide")
v = st.slider("X", min_value=-10, max_value=10, value=0)  # default: min_value=0, max_value=100, step=1, value: 시작 값
st.write("선택된 값: ", str(v))

st.subheader("날짜")
col1, col2 = st.columns(2)
v = col1.date_input("날짜")
col1.write(v)

v = col2.time_input("시간", step=60)  # step(간격) 단위: 초 (step에 입력할 수있는 시간은 60초 ~ 23시간 사이의 값을 초로 계산해서 넣거나 datetime.timedelta 로 전달.
col2.write(v)

########################################
# 다양한 입력 버튼
########################################
st.divider()
st.subheader("일반 버튼")

##### 일반버튼: click 하면 True 반환
bool_value = st.button("인사말 출력")
if not bool_value:
    st.write("아직 클릭 안됨")
else:
    if name_value:
        st.write(f"{name_value}님 안녕하세요.")
    else:
        st.write("이름을 입력하세요.")

##### 링크 버튼. 버튼 클릭시 지정한 url로 이동한다.
st.subheader("링크버튼")
col1, col2, col3 = st.columns(3)
col1.link_button("Streamlit", "https://streamlit.io/")
col2.link_button("구글", "https://google.co.kr")
col3.link_button("Naver", "https://www.naver.com")
## 화면에는 한줄에 세개가 다 나오는 문제가 있음. 
## 한줄에 대해 열을 나눠.. (동일한 너비로)
## 



####### selectbox - 정해진 틀 안에서 답을 받을 때
st.subheader("Select Box")
option = st.selectbox(
    "지역을 선택하세요",
    ("서울", "인천", "부산", "광주"),
    # index=None -- 아무것도 선택안하겠다는 옵션도 추가할 수 있다. 
)
st.write("**선택한 지역**:", option)


###### checkbox ## yes or no, 할래 말래 .. 
st.subheader("Checkbox 버튼")
bool_value = st.checkbox("정보를 수신하겠습니까?") # check: True, check 해제: False 반환
if bool_value:
    st.write("**수신 선택**")
else:
    st.write("**수신 안함 선택**")



####### file_uploader()
st.subheader("파일 업로드 버튼")
col4, col5 = st.columns(2)

uploaded_file = col4.file_uploader(
    "이미지 업로드", 
    type=["png", "jpg"],           # 업로드 파일 확장자 제한. (생략하면 모든 확장자의 파일을 다 업로드 할 수있다.)
    accept_multiple_files=False    # True 설정 시 한번에 여러개 파일 업로드 가능. (False: Default)
)

########## 업로드 된 파일 저장 ##########
import os
import io
from PIL import Image

save_dir = "save_files"
os.makedirs(save_dir, exist_ok=True)
if uploaded_file is not None:
    # UploadFile.getvalue(): 업로드된 파일을 bytes로 반환 (bytes 타입)
    # UploadFile.name      : 업로드된 파일이름 반환.
    bytes_data = uploaded_file.getvalue()
    save_filepath = os.path.join(save_dir, uploaded_file.name)
    with open(save_filepath, "wb") as fw:
        fw.write(bytes_data)
    st.write(uploaded_file.name)
    st.write("타입:" + str(type(bytes_data)))
    #################### 업로드 이미지 화면에 출력 (bytes to PIL.Image)
    data_io = io.BytesIO(bytes_data)
    img = Image.open(data_io)
    st.write(img)

####### 다중 파일 업로드.
upload_file_list = st.file_uploader(  
    "다중파일 업로드",
    accept_multiple_files=True, ## 여러개 파일 올릴 수 있게 한다. false라면 한장만.
)
st.write("업로드 파일개수:", len(upload_file_list))
for uploaded_file in upload_file_list: ## 리스트 반복문 돌림. ## 업로드 된 파일의 정보(이름, 크기)만 들어가있음. 
    bytes_data = uploaded_file.getvalue() ## 업로드된 파일의 bytes객체를 가져옴
    with open(os.path.join(save_dir, uploaded_file.name), "wb") as fw: ## 파일 이름을 바꿔서 쓸 수 있다. 
        fw.write(bytes_data)


##### 다운로드 버튼
st.subheader("다운로드 버튼")
down_filepath = "data/boston_housing.csv"
with open(down_filepath, "rb") as fr:
    st.download_button(
        "파일 다운로드",                             # Button Label
        data=fr.read(),                             # 다운로드 시킬 파일 content. (str or bytes)
        file_name=os.path.basename(down_filepath),  # 다운 로드 될 때 파일명 (경로일 경우) os.path.basename(file_path): file_path에서 마지막 경로의 이름만 반환.
    )


