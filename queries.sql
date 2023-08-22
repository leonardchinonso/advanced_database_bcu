-- Get all companies without users --
SELECT company.*
FROM company
WHERE NOT EXISTS (
  SELECT 1
  FROM sys_user
  WHERE sys_user.comp_id = company.id
);

SELECT company.*
FROM company
LEFT JOIN sys_user
ON company.id = sys_user.comp_id
WHERE sys_user.comp_id IS NULL;


-- Get all companies without loan packages --
SELECT company.*
FROM company
WHERE NOT EXISTS (
  SELECT 1
  FROM loan_package
  WHERE loan_package.comp_id = company.id
);

SELECT company.*
FROM company
LEFT JOIN loan_package
ON company.id = loan_package.comp_id
WHERE loan_package.comp_id IS NULL;

-- Get all company office addresses --
SELECT company_office_address.*
FROM company_office_address
JOIN company
ON company_office_address.comp_id = company.id
WHERE company.id = 5;

-- Get all pending loan applications --
SELECT loan_application.*
FROM loan_application
WHERE loan_application.status = 'PENDING';

-- Get all pending loan applications without approval groups --
-- TODO: Tobi to complete --

-- Get all approval groups for different loan packages group by loan_package id --
SELECT loan_package.id, approval_group.*
FROM loan_package
JOIN approval_group
ON loan_package.id = approval_group.loan_package_id
GROUP BY loan_package.id, approval_group.id;

-- Count number of approval groups for different loan packages group by loan_package id --
SELECT loan_package.id, COUNT(approval_group.id) AS num_approval_groups
FROM loan_package
JOIN approval_group
ON loan_package.id = approval_group.loan_package_id
GROUP BY loan_package.id;

-- Get all users approving a loan application --
EXPLAIN ANALYSE
select CO.ID, CO.role, AG.group_name from LOAN_APPROVAL la
join APPROVAL_GROUP AG on la.APPROVAL_GROUP_ID = AG.ID
join APPROVAL_USER_GROUP AUG on AG.ID = AUG.GROUP_ID
join COMPANY_OFFICIAL CO on AUG.COMPANY_OFFICIAL_ID = CO.ID
WHERE la.LOAN_APPLICATION_ID = 1;

-- Get
SELECT sys_user.*
FROM sys_user
INNER JOIN borrower
ON sys_user.id = borrower.id
WHERE borrower.id = 1;

-- Get borrower loan_application history --
SELECT loan_application.*
FROM loan_application
WHERE loan_application.borrower_id = 2;

-- Get current borrower loan records --
SELECT loan.*
FROM loan
WHERE loan.borrower_id = 2;

-- Get borrower loan repayment history --
SELECT loan_repayment.*
FROM loan_repayment
WHERE loan_repayment.loan_id = 1;

-- Get borrower loans not disbursed --
SELECT loan.*
FROM loan
WHERE loan.borrower_id = 2 AND loan.status = 'PENDING_DISBURSEMENT';

-- Get borrower loans disbursed and pending repayment --
SELECT loan.*
FROM loan
WHERE loan.borrower_id = 2 AND loan.status = 'DISBURSED';