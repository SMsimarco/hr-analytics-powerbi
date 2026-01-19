
-- 1. Attrition Rate by Job Role
-- Identifica qué puestos tienen mayor fuga de talento.
SELECT 
    JobRole, 
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM hr_data
GROUP BY JobRole
ORDER BY AttritionRate DESC;

-- 2. Average Monthly Income by Department and Gender
-- Analiza brechas salariales por departamento.
SELECT 
    Department, 
    Gender, 
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM hr_data
GROUP BY Department, Gender
ORDER BY Department;

-- 3. High Risk Employees (Low Satisfaction + Overtime)
-- Filtra empleados en riesgo crítico (Satisfacción < 2 y hacen horas extra).
SELECT 
    EmployeeNumber, 
    JobRole, 
    MonthlyIncome,
    OverTime,
    JobSatisfaction
FROM hr_data
WHERE OverTime = 'Yes' AND JobSatisfaction < 2
ORDER BY MonthlyIncome DESC;

-- 4. Education Field Impact on Salary
-- Compara cómo influye el área de estudio en el ingreso mensual.
SELECT 
    EducationField, 
    ROUND(AVG(MonthlyIncome), 2) AS AvgIncome,
    COUNT(*) AS EmployeeCount
FROM hr_data
GROUP BY EducationField
ORDER BY AvgIncome DESC;

-- 5. Promotion vs. Tenure Analysis
-- Relación entre años en la empresa y tiempo desde la última promoción.
SELECT 
    JobRole,
    AVG(YearsAtCompany) AS AvgTenure,
    AVG(YearsSinceLastPromotion) AS AvgYearsSincePromotion
FROM hr_data
WHERE Attrition = 'No'
GROUP BY JobRole
ORDER BY AvgYearsSincePromotion DESC;
