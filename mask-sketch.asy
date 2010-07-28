import math;
size (400, 300);

bool[] mask = {
    true, false, false, false, false,
    true, false, true, true, false,
    false, false, false, true, false
};

real WIDTH = 50.0;
transform transf = scale (6.5);

label ("Source map $a$", transf * (-0.2, 2.5), align = 1W);
label ("Source map $b$", transf * (-0.2, 1.5), align = 1W);
label ("Mask"   , transf * (-0.2, 0.5), align = 1W);

int unmasked_elements = mask.length;
for (int i = 0; i < mask.length; ++i)
{
    if (mask[i])
    {
	fill (transf * box ((i, 0.0), (i + 1, 1.0)), gray (0.4));
	--unmasked_elements;
    }
    label (format ("$a_{%d}$", i + 1), transf * (0.5 + i, 2.5));
    label (format ("$b_{%d}$", i + 1), transf * (0.5 + i, 1.5));
}

add (transf * grid (mask.length, 3));

/////////////////////////////////////////////////////////////////

transf = shift ((mask.length - unmasked_elements) * 0.5 * 6.5, -20.0) * scale (6.5);

label ("Masked map $a$", transf * (-0.2, 1.5), align = 1W);
label ("Masked map $b$", transf * (-0.2, 0.5), align = 1W);

int counter = 0;
for (int i = 0; i < mask.length; ++i)
{
    if (! mask[i])
    {
	label (format ("$a_{%d}$", i + 1), transf * (0.5 + counter, 1.5));
	label (format ("$b_{%d}$", i + 1), transf * (0.5 + counter, 0.5));
	++counter;
    }
}

add (transf * grid (unmasked_elements, 2));
