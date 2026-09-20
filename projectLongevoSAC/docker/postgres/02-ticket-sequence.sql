DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        INNER JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relkind = 'S'
          AND n.nspname = 'public'
          AND c.relname = 'tickets_id_ticket_seq'
    ) THEN
        CREATE SEQUENCE public.tickets_id_ticket_seq;
    END IF;
END $$;

ALTER SEQUENCE public.tickets_id_ticket_seq
    OWNED BY public.tickets.id_ticket;

ALTER TABLE public.tickets
    ALTER COLUMN id_ticket
    SET DEFAULT nextval('public.tickets_id_ticket_seq');

SELECT setval(
    'public.tickets_id_ticket_seq',
    COALESCE((SELECT MAX(id_ticket) FROM public.tickets), 0) + 1,
    false
);