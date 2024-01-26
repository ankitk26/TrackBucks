create
or replace function search_transactions (search_text text) returns table (
  transaction_key bigint,
  upi_ref_id bigint,
  sender_upi text,
  receiver_upi text,
  payee_name text,
  amount real,
  transaction_date timestamp with time zone,
  payment_mode character varying
) as $$
BEGIN
  RETURN QUERY
  SELECT
    x.transaction_key, x.upi_ref_id, x.sender_upi, x.receiver_upi, x.payee_name, x.amount, x.transaction_date, x.payment_mode
  FROM
    transactions x
  WHERE
    lower(x.receiver_upi) LIKE '%' || lower(search_text) || '%'
    OR lower(x.payee_name) LIKE '%' || lower(search_text) || '%' order by x.transaction_date desc;
END;
$$ language plpgsql;