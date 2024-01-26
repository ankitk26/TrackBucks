create
or replace function get_grouped_totals (p_year int) returns table (
  payee_name text,
  receiver_upi text,
  total_amount real,
  transactions_count real
) as $$
BEGIN
  RETURN QUERY
     
select distinct x.payee_name, x.receiver_upi, x.total_amount, x.transactions_count from (select t.payee_name, t.receiver_upi,  sum(t.amount) total_amount, count(t.upi_ref_id) transactions_count from transactions t where t.receiver_upi <> '9723750157@paytm' and extract('year' from t.transaction_date) = p_year group by t.payee_name, t.receiver_upi) x order by x.total_amount desc;

END;
$$ language plpgsql;
