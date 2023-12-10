SELECT * FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
JOIN pub_info ON publishers.pub_id = pub_info.pub_id;

SELECT COUNT(*) FROM authors_publishers;
SELECT COUNT(*) FROM titleauthor;

SELECT
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
    publishers.pub_id,
    publishers.pub_name,
    COUNT(titles.title_id) AS title_count
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_id, publishers.pub_name
ORDER BY title_count DESC;

SELECT * FROM sales;

SELECT
	authors.au_id,
    authors.au_lname,
    authors.au_fname,
    SUM(sales.qty) AS total_sales
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total_sales DESC
LIMIT 3;

SELECT
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
    COALESCE(SUM(sales.qty), 0) AS total_sales
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total_sales DESC;