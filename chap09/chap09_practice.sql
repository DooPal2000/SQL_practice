-- 잊기 전에 한 번 더 정답

--9-1 답변

SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
  WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN');


-- 9-1 답
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND JOB = (SELECT JOB
                FROM EMP
               WHERE ENAME = 'ALLEN'); 

-- 9-2 답변
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, E.GRADE
  FROM EMP E, DEPT D, SALGRADE S
  WHERE E.DEPTNO = D.DEPTNO
    AND SAL > (SELECT AVG(SAL) FROM EMP )
  ORDER BY E.SAL ASC, E.EMPNO DESC
-- ⭐ 오름차순 내림차순 헷갈리지 말것
-- ⭐ GRADE 추출을 위해 BETWEEN 활용할 것

-- 9-2 답
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > (SELECT AVG(SAL)
                FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO; 


-- 9-3 답변
SELECT  E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 10
    AND E.JOB NOT IN (SELECT JOB FROM DEPT WHERE DEPTNO = 30)

-- ⭐ 중복처리 DISTINCT 꼭 들어가야하는지는 내일 체크

-- 9-3 답
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 10
   AND JOB NOT IN (SELECT DISTINCT JOB
                     FROM EMP
                    WHERE DEPTNO = 30); 


-- 9-4 답변
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;


SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
  WHERE E.SAL > (SELECT DISTINCT SAL FROM EMP WHERE JOB = 'SALESMAN') -- 비교해주는 ALL 잊지 말기
ORDER BY E.EMPNO;

-- ⭐   WHERE E.SAL > (SELECT DISTINCT SAL FROM EMP WHERE JOB = 'SALESMAN') 
-- 다중행 함수 부분이 틀렸음 


-- 9-4
-- 다중행 함수 사용하지 않는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > (SELECT MAX(SAL)
                FROM EMP
               WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO; 

--다중행 함수 사용하는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ALL (SELECT DISTINCT SAL
                    FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO; 