DECLARE
  l_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_exists
  FROM pc_lista_comanda
  WHERE cod_pc = :P7_COD_PC
    AND cod_c = :P7_COD_C;

  IF l_exists = 0 THEN
    INSERT INTO pc_lista_comanda (cod_pc, cod_c, cantitate)
    VALUES (:P7_COD_PC, :P7_COD_C, :P7_CANTITATE);
    apex_application.g_print_success_message := 'Produsul a fost adaugat comenzii.';
  ELSE
    UPDATE pc_lista_comanda
    SET cantitate = cantitate + :P7_CANTITATE
    WHERE cod_pc = :P7_COD_PC
      AND cod_c = :P7_COD_C;

    -- Display message for user
    apex_application.g_print_success_message := 'Cantitatea a fost actualizată pentru componenta deja existentă.';
  END IF;

  :P7_COD_PC := NULL;
  :P7_COD_C := NULL;
  :P7_CANTITATE := NULL;
END;
