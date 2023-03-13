[CmdletBinding()]
param (
    [string]
    [Parameter(Mandatory)]
    [ValidateSet("PostgreSQL", "Postgres", "SqlServer")]
    $ParamName
)
process {
}
end {
}