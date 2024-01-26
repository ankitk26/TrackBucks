create
or replace function get_transaction_totals () returns table (year integer, month integer, total_amount real) as $$
BEGIN
  RETURN QUERY
    select
      cast(extract(
        year
        from
          transaction_date
      ) as integer) as year,
      cast(extract(
        month
        from
          transaction_date
      )  as integer) as month,
      sum(amount) as total_amount
    from
      transactions
    group by
      year,
      month
    order by
      year,
      month;
END;
$$ language plpgsql;
