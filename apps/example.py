import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
plt.plot([1,2,3,4])
plt.ylabel('some numbers')
plt.show()

plt.savefig('iexec/example.png')
