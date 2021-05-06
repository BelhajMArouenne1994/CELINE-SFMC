SELECT
    ISP,
    [Week Number],
    [Day Number],
    Count(1) AS 'Count',
    MIN([Last Open Date]) AS 'Min Last Open Date',
    MAX([Last Open Date]) AS 'Max Last Open Date'
FROM
    [Ramp Up Data] A
    JOIN [Ramp Up Cheetah Data] B ON A.[Account Id] = B.[Account Id]
GROUP BY
    ISP,
    [Week Number],
    [Day Number]