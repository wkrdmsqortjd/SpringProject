# *BookShop 프로젝트*
 
### 🛒**책 쇼핑몰 프로젝트**
<br>

 ```
 SpringFramework를 이용해 책을 판매하는 쇼핑몰을 제작하였습니다.
 사용자들은 회원가입, 로그인, 상품 구매, 검색 등의 기능을 할 수 있고,
 관리자또한 위의 기능 이외에도 작가관리(수정, 등록, 삭제) , 상품관리(수정, 등록, 삭제) , 주문 관리(주문 취소) 등을 구현했습니다.
 ```

 ## 💻 사용한 기술
---
<br>

🔎 백앤드
- JAVA 
- Spring MVC
- Spring Security
- Spring AOP
- MyBatis
- JUnit4
- LomBok

🔎 DB & WAS
- Oracle
- Apach Tomcat 9
- ERD Cloud

🔎 프론트앤드
- HTML/CSS
- JavaScript
- Bootstrap 5
- Jquery

🔎 Environment & Tool
- Windows 10
- Eclipse
- VSCode
- GitHub
- Sql developer
<br>
<br>

## 🔑 핵심 및 프로젝트 키워드
---

### 📒 Spring를 사용해 MVC 패턴에 대한 이해도 상승
### 📒 다양한 에러 해결과 기능 구현을 통한 경험 상승
### 📒 Junit을 이용한 단위 테스트
### 📒 Spring Security를 이용한 비밀번호 암호화
### 📒 TransAction을 사용

<br>
<br>

## 📜 프로젝트 구현 기능
---
<br>

+ 사용자
    - 회원가입
    - 로그인 / 로그아웃
    - 상품 검색(책 제목, 작가, 카테고리)
    - 장바구니(담기, 삭제, 수량 변경, 주문)
    - 상품 주문
    - 상품 리뷰 작성   
+ 관리자
    - 작가 관리(등록, 수정, 삭제)
    - 상품 관리(등록, 수정, 삭제)
    - 주문 현황(주문 취소, 확인)

    


<br>

## 📂 DB 설계
---
<br>

![BookShop(ERD)](https://user-images.githubusercontent.com/97008707/187075319-b8abd306-54de-4041-a26f-ae7595754dc1.png)

<br>

## 📂 전체 흐름도
---
<br>

![BookShop(Usecase)](https://user-images.githubusercontent.com/97008707/187075618-2a029b19-c40a-439a-808a-f8d2e673f45a.png)

<br>

## 📺 기능 구현 UI
---
<br>
<details>
    <summary> 회원 기능 </summary>
    <div markdown="1">
    <br>
    <p align="center"> 1. 회원가입 </p>
    <p align="center">
    <img width="217" height="300" alt="SignUp" src="https://user-images.githubusercontent.com/97008707/187401164-3433ffd1-1da7-456b-999f-5655de3c90b1.png">
    </p>
    <p align="center"> 2. 로그인 </p>
    <p align="center">
    <img width="221" alt="LogIn" src="https://user-images.githubusercontent.com/97008707/187401390-e21977c9-ac14-4dd3-93ca-113620012960.png">
    </p>
    <p align="center"> 3. 메인 페이지 </p>
    <p align="center">
    <img width="914" alt="Main" src="https://user-images.githubusercontent.com/97008707/187401768-8e4a6992-63f5-467b-a14d-c8c01afa1956.png">
    </p>
    <p align="center"> 4. 주문 페이지 </p>
    <p align="center">
    <img width="930" alt="Order" src="https://user-images.githubusercontent.com/97008707/187402043-dc83c892-bbb0-4e01-8d11-4fed9fd85a4e.png">
    </p>
    <p align="center">5. 장바구니 페이지 </p>
    <img width="918" alt="Cart" src="https://user-images.githubusercontent.com/97008707/187402161-76a20834-dd5d-4bdc-a64c-94b41d4447d5.png">
    </p>
    <p align="center"> 6. 상품 상세 페이지 </p>
    <img width="747" alt="GoodDetail" src="https://user-images.githubusercontent.com/97008707/187402663-40b37f6c-4cc5-4590-bd88-7e6c293154e1.png">
    </p>
    <p align="center"> 7. 댓글 </p>  
    <p align="center">
    <img width="269" alt="Review" src="https://user-images.githubusercontent.com/97008707/187402807-901aa282-a3ac-4e66-88bb-69cfb9ed3732.png">
    </p>
    <p align="center"> 8. 검색 페이지 </p>
    <p align="center">
    <img width="804" alt="Serch" src="https://user-images.githubusercontent.com/97008707/187403151-6571ac99-cc8d-42d6-818a-4c599b8478dd.png">
    <p>
    <br>
    </details>

<details>
    <summary> 관리자 기능 </summary>
    <div markdown="1">
    <br>
    <p align="center"> 1. 작가 관리 </p>
    <p align="center">
    <img width="698" alt="AuthorManage" src="https://user-images.githubusercontent.com/97008707/187419580-20e5f8b5-b1d9-47bf-b4fe-aab5166bfbea.png">
    <p>
    <p align="center"> 2. 작가 등록 </p>
    <p align="center">
    <img width="707" alt="AuthorEnroll" src="https://user-images.githubusercontent.com/97008707/187419813-cbe4735d-5aac-496b-ae48-a38c3c7ccf7e.png">
    <p>
    <p align="center"> 3. 상품 관리 </p>
    <img width="704" alt="GoodsManage" src="https://user-images.githubusercontent.com/97008707/187420505-f620cb0f-8055-49a2-ba17-e052a22fc642.png">
    <p>
    <p align="center"> 4. 상품 등록 </p>
    <img width="697" alt="GoodsEnroll" src="https://user-images.githubusercontent.com/97008707/187420764-0fe78dec-4826-4e76-9071-2473c7a9ce32.png">
    <p>
    <p align="center"> 5. 주문 현황 </p>
    <img width="715" alt="orderList ng" src="https://user-images.githubusercontent.com/97008707/187421078-a690ea89-3c20-4aeb-aa5b-4c10d8d7ba3d.png">
    <p>
</details>

<br>
<br>

## 🏆 프로젝트 후기
---
<br>
코딩에 관심을 가지고 국비과정을 거치며 마지막으로 배운 Spring에 대해 더 이해하고 공부를 하고싶었기 때문에 블로그와 책등을 참고하여 프로젝트를 만들게 되었습니다.

<br>

학원을 수료하는 중 간단한 슈팅게임(Java 프로젝트)를 만든 경험이 있지만 웹을 구현하며 만들어야하는 <mark>Spring MVC 패턴은 **협업**과 **설계**가 너무나도 중요하다는 것을 깨달았습니다</mark>. 
<br>

공부 목적으로 시작한 프로젝트이기 때문에 제대로된 설계(흐름도, ERD) 등을 하지 못하였지만 진행과정에서 많은 도움이 되었고 더욱 모티브가되어 코딩에 대한 흥미가 더해졌습니다.
<br>

이번 프로젝트를 하면서 <mark>**GitHub**의 기본적인 사용방법을 익혀 협업하는 방식</mark>을 깨달았고, 에러에 대한 문제점을 더 효과적으로 접근할 수 있는 방법을 터득하고,
<mark>**테스트 코드**를 짜며 프로젝트를 진행함으로 더욱 완성도 있는 프로젝트를 만들 수 있다는것과 프로젝트의 내용 및 에러사항들을 메모</mark>해야한 다는것을 알게된 좋은 경험을 준 프로젝트 였습니다.




