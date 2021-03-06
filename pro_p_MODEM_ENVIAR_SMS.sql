--EXEC [dbo].[pro_p_MODEM_ENVIAR_SMS] '',''

CREATE PROCEDURE [dbo].[pro_p_MODEM_ENVIAR_SMS] (
	@Numero                     VARCHAR(11) = '', --DDDXXXXX-XXXX
	@Messagem				    VARCHAR(130) = '' 
 )
AS
BEGIN 
    SET NOCOUNT ON;
    ---------
    -- LOG --
    ---------
	-- #################################################################################
    DECLARE @Log_txParamentros varchar(MAX) = NULL
    SET @Log_txParamentros = CONCAT (
        'EXEC pro_v_Funcionario',
		', @Numero=',   CONVERT(VARCHAR, ISNULL(@Numero, '')),
		', @Messagem=',   CONVERT(VARCHAR, ISNULL(@Messagem, ''))
	)
		
	INSERT INTO [dbo].[Logs] ([Log_NameProced], [Log_txParamentros], [Log_data])
	VALUES ('pro_p_MODEM_ENVIAR_SMS', @Log_txParamentros,GETDATE())
	-- #################################################################################

	-------------------------
	----   VARIAVEIS --------
	-------------------------
	DECLARE @GETURL VARCHAR(200) = NULL
    
	SET @GETURL = 'http://localhost:44359' --

	SET @GETURL = CONCAT(@GETURL, '/Enviar?Numero=',@Numero,'&Mensagem=',@Messagem)
    PRINT @GETURL
    IF (LEN(RTRIM(ISNULL(@GETURL, ''))) > 0)    				
		BEGIN 
			DECLARE @win int = 0
			DECLARE @hr  int = 0
			DECLARE @response varchar(4000) = NULL

			EXEC @hr=sp_OACreate 'WinHttp.WinHttpRequest.5.1', @win OUTPUT 
			IF @hr <> 0 EXEC sp_OAGetErrorInfo @win
		
			EXEC @hr=sp_OAMethod @win, 'Open',NULL,'GET',@GETURL,'false'
			IF @hr <> 0 EXEC sp_OAGetErrorInfo @win
					
			EXEC @hr=sp_OAMethod @win, 'Send'
			IF @hr <> 0 EXEC sp_OAGetErrorInfo @win

			EXEC @hr=sp_OAGetProperty @win, 'ResponseText', @response OUTPUT
			IF @hr <> 0 EXEC sp_OAGetErrorInfo @win

			EXEC @hr=sp_OADestroy @win 
			IF @hr <> 0 EXEC sp_OAGetErrorInfo @win
			END
            
    SELECT @response AS '@response' 

END





