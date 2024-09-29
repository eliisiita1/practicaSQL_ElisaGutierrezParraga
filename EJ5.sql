WITH document_number as
(SELECT ivr_id,document_identification  FROM `keepcoding.ivr_steps`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY document_identification) = 1),
document_type as
(SELECT ivr_id,document_type  FROM `keepcoding.ivr_steps`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY document_type) = 1)

SELECT document_number.ivr_id,
    IF (document_number.document_identification = 'UNKNOWN', 'DESCONOCIDO',document_number.document_identification),
    IF (document_type.document_type = 'UNKNOWN', 'DESCONOCIDO',document_type.document_type)
    
FROM document_number
LEFT JOIN document_type
ON document_number.ivr_id =  document_type.ivr_id