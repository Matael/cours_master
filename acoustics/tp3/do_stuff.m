function [f, vals, ref, phases] = do_stuff(stuff, r)

    [f, vals, ref] = extract_values(stuff, r);
    phases = []

    for i=1:3
        phases = [phases unwrap(angle(vals(:,i)))];
    end
    figure;
    for i=1:3
        subplot(3,1,i)
        plot(f, phases(:,i))
        grid on;
        ylabel(['H_{' num2str(r) num2str(1+i) '}']);
    end
 end