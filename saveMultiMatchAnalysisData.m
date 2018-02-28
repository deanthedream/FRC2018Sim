%% Name of file to save to
fname = strcat('match',num2str(cputime*100),'.dat');

lm = length(m);
redScore = m(lm).redScore;%redScore at end of match
blueScore = m(lm).blueScore;%blueScore at end of match
rSourceContents = sum(m(lm).ssl.r.sourceContent);%red source contents remaining
bSourceContents = sum(m(lm).ssl.b.sourceContent);%blue source contents remaining
for i = 1:6
    rscs(i) = m(lm).r.r(i).scaleScore;%roboti scaleScore time
    rsws(i) = m(lm).r.r(i).switchScore;%roboti switchScore time
    rs(i) = m(lm).r.r(i).d.speed;%roboti speed
    rstratPriority(i,:) = m(lm).r.s(1).priority;%robot scoring priority
end
rwl = (redScore > blueScore);%boolean indicating whether red team won or lost



%%
try
    ftemp = fopen(fname,'W');
    tmpstr = '';
    for k = 1:47
        tmpstr = strcat(tmpstr,'%f,');
    end
    Fmt = tmpstr;
    disp('here1')
    datVect = [redScore, blueScore, rSourceContents, bSourceContents,rwl,...%5
        rscs(1), rscs(2),rscs(3),rscs(4),rscs(5),rscs(6),...%6
        rsws(1), rsws(2), rsws(3), rsws(4), rsws(5), rsws(6),...%6
        rs(1), rs(2), rs(3), rs(4), rs(5), rs(6),...%6
        rstratPriority(1,1), rstratPriority(1,2), rstratPriority(1,3), rstratPriority(1,4),...
        rstratPriority(2,1), rstratPriority(2,2), rstratPriority(2,3), rstratPriority(2,4),...
        rstratPriority(3,1), rstratPriority(3,2), rstratPriority(3,3), rstratPriority(3,4),...
        rstratPriority(4,1), rstratPriority(4,2), rstratPriority(4,3), rstratPriority(4,4),...
        rstratPriority(5,1), rstratPriority(5,2), rstratPriority(5,3), rstratPriority(5,4),...
        rstratPriority(6,1), rstratPriority(6,2), rstratPriority(6,3), rstratPriority(6,4)];%24
    fprintf(ftemp,Fmt, datVect);
    disp('Wrote To File')
    fclose(ftemp);
catch me
    disp('exception')
    fclose(ftemp);
    rethrow(me);
end
