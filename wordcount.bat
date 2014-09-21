@echo off
set tempdoc=texcount_details.html
texcount -dir -inc -html C:\Users\jenc2\Documents\GitHub\Thesis\thesis.tex > %tempdoc%
:start %tempdoc%
pause
