---@diagnostic disable

dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

local translations = {
  ["english"] = {
    ["title"] = "Raytraced Black Holes",
    ["on"] = "On",
    ["off"] = "Off",
    ["performance_settings"] = "Performance Settings",
    ["performance_settings_desc"] = "Settings that impact performance.",
    ["run_benchmark"] = "Run Benchmark",
    ["run_benchmark_desc"] = "Run a short benchmark to determine the best settings for your system.",
    ["min_framerate"] = "Min Framerate",
    ["min_framerate_desc"] = "Automatically render less black holes to stay above this framerate.\nDisable by setting to 0.",
    ["max_holes"] = "Max Black Holes",
    ["max_holes_desc"] = "Maximum number of Black and White holes.",
    ["accretion_disks"] = "Accretion Disks",
    ["accretion_disks_desc"] = "Enable Accretion Disks.",
    ["max_accretion_disks"] = "Max Accretion Disks",
    ["max_accretion_disks_desc"] = "Maximum number of Accretion Disks.",
    ["accretion_disks_on_small_black_holes"] = "Accretion Disks on small black holes",
    ["accretion_disks_on_small_black_holes_desc"] = "Enable Accretion Disks on small black holes. \nMay clutter the screen.",
    ["advanced_settings"] = "Advanced Settings",
    ["advanced_settings_desc"] = "Fine-tune settings.",
    ["max_raymarching_steps"] = "Max raymarching steps",
    ["max_raymarching_steps_desc"] = "Maximum number of raymarching steps to take per pixel.\n16-24 will be enough.",
    ["other_visual_settings"] = "Other Visual Settings",
    ["other_visual_settings_desc"] = "Other visual settings that don't impact performance.",
    ["accretion_disc_bloom_intensity"] = "Accretion Disk bloom intensity",
    ["accretion_disc_bloom_intensity_desc"] = "How brightly Accretion Disks will glow.",
    ["disk_effect_opacity"] = "Accretion Disk effect opacity",
    ["disk_effect_opacity_desc"] = "Apply transparency to Accretion Disks.",
    ["white_hole_bloom_intensity"] = "White Hole bloom intensity",
    ["white_hole_bloom_intensity_desc"] = "How brightly White Holes will glow.",
    ["invert_white_holes"] = "Invert white hole mass",
    ["invert_white_holes_desc"] = "Use positive mass values for White Holes instead of negative.",
    ["gravitational_lensing_effect_scale"] = "Gravitational lensing effect scale",
    ["gravitational_lensing_effect_scale_desc"] = "Apply a scaling factor to the gravitational lensing effect.\nEquivelant to changing the simulated speed of light.",
    ["can_only_benchmark_while_in_game"] = "Can only benchmark while in-game.",
    ["right_click_to_reset"] = "Right-click a setting to restore it to default.",
    ["high_score"] = "High Score",
    ["score"] = "Score",
    ["recompile_warning"] = "Changes will require shader recompile on next restart (around 1 minute).",
    ["hard_cap"] = "Shader Black Hole limit",
    ["hard_cap_desc"] = "Compile the shader to support a different number of max Black Holes.\nSmaller values improve performance.\nVery high values will hang or crash low-end GPUs, and will take a few\nminutes to compile on the next restart.",
  },
  ["русский"] = {
    ["title"] = "Рейтрейсинг черных дыр",
    ["on"] = "Включено",
    ["off"] = "Выключено",
    ["performance_settings"] = "Настройки производительности",
    ["performance_settings_desc"] = "Настройки, влияющие на производительность.",
    ["run_benchmark"] = "Запустить тест",
    ["run_benchmark_desc"] = "Запустить короткий тест для определения наилучших настроек для вашей системы.",
    ["max_holes"] = "Максимум черных дыр",
    ["max_holes_desc"] = "Максимальное количество черных и белых дыр.",
    ["accretion_disks"] = "Аккреционные диски",
    ["accretion_disks_desc"] = "Включить аккреционные диски.",
    ["max_accretion_disks"] = "Максимум аккреционных дисков",
    ["max_accretion_disks_desc"] = "Максимальное количество аккреционных дисков.",
    ["accretion_disks_on_small_black_holes"] = "Аккреционные диски на малых чёрных дырах",
    ["accretion_disks_on_small_black_holes_desc"] = "Включить аккреционные диски на малых чёрных дырах. \nМожет загромождать экран.",
    ["advanced_settings"] = "Дополнительные настройки",
    ["advanced_settings_desc"] = "Тонкая настройка параметров.",
    ["max_raymarching_steps"] = "Макс. шагов лучевого марша",
    ["max_raymarching_steps_desc"] = "Максимальное количество шагов лучевого марша на пиксель.\n16-24 будет достаточно.",
    ["other_visual_settings"] = "Прочие визуальные настройки",
    ["other_visual_settings_desc"] = "Прочие визуальные настройки, не влияющие на производительность.",
    ["accretion_disc_bloom_intensity"] = "Интенсивность свечения аккреционного диска",
    ["accretion_disc_bloom_intensity_desc"] = "Насколько ярко будут светиться\nаккреционные диски.",
    ["disk_effect_opacity"] = "Прозрачность эффекта аккреционного диска",
    ["disk_effect_opacity_desc"] = "Применить прозрачность к аккреционным дискам.",
    ["white_hole_bloom_intensity"] = "Интенсивность свечения белой дыры",
    ["white_hole_bloom_intensity_desc"] = "Насколько ярко будут светиться белые дыры.",
    ["invert_white_holes"] = "Inverter massa dos Buracos Brancos",
    ["invert_white_holes_desc"] = "Usar valores de massa positivos para buracos brancos em vez de negativos.",
    ["gravitational_lensing_effect_scale"] = "Масштаб эффекта гравитационного линзирования",
    ["gravitational_lensing_effect_scale_desc"] = "Применить коэффициент масштабирования\nк эффекту гравитационного линзирования.\nЭквивалентно изменению скорости света\nв симуляции.",
    ["can_only_benchmark_while_in_game"] = "Тест можно провести только в игре.",
    ["right_click_to_reset"] = "Щелкните правой кнопкой мыши, чтобы восстановить настройку по умолчанию.",
    ["high_score"] = "Лучший счёт",
    ["score"] = "Счёт",
    ["recompile_warning"] = "Изменения потребуют перекомпиляции шейдеров при следующем запуске (около 1 минуты).",
    ["hard_cap"] = "Предел количества Чёрных Дыр в шейдере",
    ["hard_cap_desc"] = "Компиляция шейдера для поддержки другого\nколичества максимальных Чёрных Дыр.\nМеньшие значения улучшают производительность.\nОчень высокие значения могут привести к\nзависанию или сбою на маломощных GPU, а\nкомпиляция займёт несколько минут при\nследующем запуске.",

  },
  ["Português (Brasil)"] = {
    ["title"] = "Buracos Negros com Ray Tracing",
    ["on"] = "Ligado",
    ["off"] = "Desligado",
    ["performance_settings"] = "Configurações de Desempenho",
    ["performance_settings_desc"] = "Configurações que impactam o desempenho.",
    ["run_benchmark"] = "Executar Benchmark",
    ["run_benchmark_desc"] = "Execute um pequeno benchmark para determinar as melhores configurações para o seu sistema.",
    ["max_holes"] = "Máximo de Buracos Negros",
    ["max_holes_desc"] = "Número máximo de buracos negros e brancos.",
    ["accretion_disks"] = "Discos de Acréscimo",
    ["accretion_disks_desc"] = "Ativar Discos de Acréscimo.",
    ["max_accretion_disks"] = "Máximo de Discos de Acreção",
    ["max_accretion_disks_desc"] = "Número máximo de discos de acreção.",
    ["accretion_disks_on_small_black_holes"] = "Discos de Acréscimo em pequenos buracos negros",
    ["accretion_disks_on_small_black_holes_desc"] = "Ativar Discos de Acréscimo em pequenos buracos negros. \nPode poluir a tela.",
    ["advanced_settings"] = "Configurações Avançadas",
    ["advanced_settings_desc"] = "Ajuste fino das configurações.",
    ["max_raymarching_steps"] = "Máx. de passos de raymarching",
    ["max_raymarching_steps_desc"] = "Número máximo de passos de raymarching por pixel.\n16-24 serão suficientes.",
    ["other_visual_settings"] = "Outras Configurações Visuais",
    ["other_visual_settings_desc"] = "Outras configurações visuais que não impactam o desempenho.",
    ["accretion_disc_bloom_intensity"] = "Intensidade de bloom do Disco de Acréscimo",
    ["accretion_disc_bloom_intensity_desc"] = "Quão intensamente os Discos de Acréscimo irão brilhar.",
    ["disk_effect_opacity"] = "Opacidade do efeito do Disco de Acréscimo",
    ["disk_effect_opacity_desc"] = "Aplicar transparência aos Discos de Acréscimo.",
    ["white_hole_bloom_intensity"] = "Intensidade de bloom do Buraco Branco",
    ["white_hole_bloom_intensity_desc"] = "Quão intensamente os Buracos Brancos irão brilhar.",
    ["invert_white_holes"] = "Inverter massa dos Buracos Brancos",
    ["invert_white_holes_desc"] = "Usar valores de massa positivos para buracos brancos em vez de negativos.",
    ["gravitational_lensing_effect_scale"] = "Escala do efeito de lente gravitacional",
    ["gravitational_lensing_effect_scale_desc"] = "Aplicar um fator de escala ao efeito de lente gravitacional.\nEquivalente a alterar a velocidade simulada da luz.",
    ["can_only_benchmark_while_in_game"] = "Benchmark só pode ser executado enquanto estiver no jogo.",
    ["right_click_to_reset"] = "Clique com o botão direito para restaurar a configuração para o padrão.",
    ["high_score"] = "Pontuação Máxima",
    ["score"] = "Pontuação",
    ["recompile_warning"] = "Los cambios requerirán recompilar los shaders en el próximo reinicio (aproximadamente 1 minuto).",
    ["hard_cap"] = "Limite de Buracos Negros no Shader",
    ["hard_cap_desc"] = "Compile o shader para suportar um número diferente de\nBuracos Negros máximos.\nValores menores melhoram o desempenho.\nValores muito altos podem travar ou causar falhas em GPUs de\nbaixo desempenho, e levarão alguns minutos para compilar na\npróxima reinicialização.",

  },
  ["Español"] = {
    ["title"] = "Agujeros Negros con Ray Tracing",
    ["on"] = "Encendido",
    ["off"] = "Apagado",
    ["performance_settings"] = "Configuración de Rendimiento",
    ["performance_settings_desc"] = "Configuraciones que afectan el rendimiento.",
    ["run_benchmark"] = "Ejecutar Benchmark",
    ["run_benchmark_desc"] = "Ejecuta un breve benchmark para determinar las mejores configuraciones para tu sistema.",
    ["max_holes"] = "Máximo de Agujeros Negros",
    ["max_holes_desc"] = "Número máximo de agujeros negros y blancos.",
    ["accretion_disks"] = "Discos de Acreción",
    ["accretion_disks_desc"] = "Habilitar Discos de Acreción",
    ["max_accretion_disks"] = "Máximo de Discos de Acreción",
    ["max_accretion_disks_desc"] = "Número máximo de discos de acreción.",
    ["accretion_disks_on_small_black_holes"] = "Discos de Acreción en agujeros negros pequeños",
    ["accretion_disks_on_small_black_holes_desc"] = "Habilitar Discos de Acreción en agujeros negros pequeños.\nPuede saturar la pantalla.",
    ["advanced_settings"] = "Configuración Avanzada",
    ["advanced_settings_desc"] = "Ajuste fino de configuraciones.",
    ["max_raymarching_steps"] = "Máx. pasos de raymarching",
    ["max_raymarching_steps_desc"] = "Número máximo de pasos de raymarching por píxel.\n16-24 serán suficientes.",
    ["other_visual_settings"] = "Otras Configuraciones Visuales",
    ["other_visual_settings_desc"] = "Otras configuraciones visuales que no afectan el rendimiento.",
    ["accretion_disc_bloom_intensity"] = "Intensidad de brillo del Disco de Acreción",
    ["accretion_disc_bloom_intensity_desc"] = "Qué tan intensamente brillarán los Discos de Acreción.",
    ["disk_effect_opacity"] = "Opacidad del efecto del Disco de Acreción",
    ["disk_effect_opacity_desc"] = "Aplicar transparencia a los Discos de Acreción.",
    ["white_hole_bloom_intensity"] = "Intensidad de brillo del Agujero Blanco",
    ["white_hole_bloom_intensity_desc"] = "Qué tan intensamente brillarán los Agujeros Blancos.",
    ["invert_white_holes"] = "Invertir masa de los Agujeros Blancos",
    ["invert_white_holes_desc"] = "Usar valores de masa positivos para los agujeros blancos en lugar\nde negativos.",
    ["gravitational_lensing_effect_scale"] = "Escala del efecto de lente gravitacional",
    ["gravitational_lensing_effect_scale_desc"] = "Aplicar un factor de escala al efecto de lente gravitacional.\nEquivalente a cambiar la velocidad simulada de la luz.",
    ["can_only_benchmark_while_in_game"] = "Solo se puede ejecutar el benchmark en el juego.",
    ["right_click_to_reset"] = "Haz clic derecho en una configuración para restaurarla a su valor predeterminado.",
    ["high_score"] = "Puntuación Alta",
    ["score"] = "Puntuación",
    ["recompile_warning"] = "Los cambios requerirán recompilar los shaders en el próximo reinicio (aproximadamente 1 minuto).",
    ["hard_cap"] = "Límite de Agujeros Negros en el Shader",
    ["hard_cap_desc"] = "Compila el shader para soportar un número diferente de\nAgujeros Negros máximos.\nValores más bajos mejoran el rendimiento.\nValores muy altos pueden colgar o bloquear GPUs de gama\nbaja, y tomará unos minutos compilar en el próximo reinicio.",
  },
  ["Deutsch"] = {
    ["title"] = "Raytracing Schwarze Löcher",
    ["on"] = "Ein",
    ["off"] = "Aus",
    ["performance_settings"] = "Leistungseinstellungen",
    ["performance_settings_desc"] = "Einstellungen, die die Leistung beeinflussen.",
    ["run_benchmark"] = "Benchmark ausführen",
    ["run_benchmark_desc"] = "Führen Sie einen kurzen Benchmark durch, um die besten Einstellungen für Ihr System zu bestimmen.",
    ["max_holes"] = "Maximale Anzahl Schwarzer Löcher",
    ["max_holes_desc"] = "Maximale Anzahl von Schwarzen und Weißen Löchern.",
    ["accretion_disks"] = "Akkretionsscheiben",
    ["accretion_disks_desc"] = "Akkretionsscheiben aktivieren",
    ["max_accretion_disks"] = "Maximale Anzahl von Akkretionsscheiben",
    ["max_accretion_disks_desc"] = "Maximale Anzahl von Akkretionsscheiben.",
    ["accretion_disks_on_small_black_holes"] = "Akkretionsscheiben auf kleinen Schwarzen Löchern",
    ["accretion_disks_on_small_black_holes_desc"] = "Akkretionsscheiben auf kleinen Schwarzen Löchern aktivieren. \nKann den Bildschirm überladen.",
    ["advanced_settings"] = "Erweiterte Einstellungen",
    ["advanced_settings_desc"] = "Feineinstellungen vornehmen.",
    ["max_raymarching_steps"] = "Maximale Raymarching-Schritte",
    ["max_raymarching_steps_desc"] = "Maximale Anzahl von Raymarching-Schritten pro Pixel.\n16-24 sind ausreichend.",
    ["other_visual_settings"] = "Weitere visuelle Einstellungen",
    ["other_visual_settings_desc"] = "Weitere visuelle Einstellungen, die die Leistung nicht beeinflussen.",
    ["accretion_disc_bloom_intensity"] = "Blühintensität der Akkretionsscheibe",
    ["accretion_disc_bloom_intensity_desc"] = "Wie hell die Akkretionsscheiben leuchten.",
    ["disk_effect_opacity"] = "Transparenz des Akkretionsscheiben-Effekts",
    ["disk_effect_opacity_desc"] = "Wenden Sie Transparenz auf Akkretionsscheiben an.",
    ["white_hole_bloom_intensity"] = "Blühintensität des Weißen Lochs",
    ["white_hole_bloom_intensity_desc"] = "Wie hell die Weißen Löcher leuchten.",
    ["invert_white_holes_desc"] = "Verwenden Sie positive Massenwerte für weiße Löcher anstelle von negativen.",
    ["invert_white_holes"] = "Masse von Weißen Löchern umkehren",
    ["gravitational_lensing_effect_scale"] = "Skalierung des Gravitationslinseneffekts",
    ["gravitational_lensing_effect_scale_desc"] = "Wenden Sie einen Skalierungsfaktor auf den\nGravitationslinseneffekt an.\nÄquivalent zur Änderung der simulierten\nLichtgeschwindigkeit.",
    ["can_only_benchmark_while_in_game"] = "Benchmark nur im Spiel möglich.",
    ["right_click_to_reset"] = "Rechtsklick auf eine Einstellung, um sie auf Standard zurückzusetzen.",
    ["high_score"] = "Höchstpunktzahl",
    ["score"] = "Punktzahl",
    ["recompile_warning"] = "Änderungen erfordern eine Neukompilierung der Shader beim nächsten Neustart (etwa 1 Minute).",
    ["hard_cap"] = "Shader-Schwazloch-Grenze",
    ["hard_cap_desc"] = "Kompiliere den Shader, um eine andere maximale Anzahl von\nSchwarze Löcher zu unterstützen.\nKleinere Werte verbessern die Leistung.\nSehr hohe Werte können bei leistungsschwachen GPUs zu Abstürzen\nführen und die Kompilierung beim nächsten Neustart einige\nMinuten dauern.",
  },
  ["Français"] = {
    ["title"] = "Trous Noirs en Ray Tracing",
    ["on"] = "Activé",
    ["off"] = "Désactivé",
    ["performance_settings"] = "Paramètres de performance",
    ["performance_settings_desc"] = "Paramètres qui impactent la performance.",
    ["run_benchmark"] = "Exécuter un benchmark",
    ["run_benchmark_desc"] = "Exécutez un court benchmark pour déterminer les meilleurs paramètres pour votre système.",
    ["max_holes"] = "Nombre max de Trous Noirs",
    ["max_holes_desc"] = "Nombre maximum de trous noirs et blancs.",
    ["accretion_disks"] = "Disques d'accrétion",
    ["accretion_disks_desc"] = "Activer les disques d'accrétion",
    ["max_accretion_disks"] = "Nombre max de Disques d'Accrétion",
    ["max_accretion_disks_desc"] = "Nombre maximum de disques d'accrétion.",
    ["accretion_disks_on_small_black_holes"] = "Disques d'accrétion sur les petits trous noirs",
    ["accretion_disks_on_small_black_holes_desc"] = "Activer les disques d'accrétion sur les petits trous noirs.\nPeut encombrer l'écran.",
    ["advanced_settings"] = "Paramètres avancés",
    ["advanced_settings_desc"] = "Réglage fin des paramètres.",
    ["max_raymarching_steps"] = "Étapes de raymarching max",
    ["max_raymarching_steps_desc"] = "Nombre maximum d'étapes de raymarching à effectuer par pixel.\n16-24 devraient suffire.",
    ["other_visual_settings"] = "Autres paramètres visuels",
    ["other_visual_settings_desc"] = "Autres paramètres visuels qui n'impactent pas la performance.",
    ["accretion_disc_bloom_intensity"] = "Intensité de l'effet de bloom du disque d'accrétion",
    ["accretion_disc_bloom_intensity_desc"] = "Intensité de la lueur des disques d'accrétion.",
    ["disk_effect_opacity"] = "Opacité de l'effet de disque d'accrétion",
    ["disk_effect_opacity_desc"] = "Appliquer de la transparence aux disques d'accrétion.",
    ["white_hole_bloom_intensity"] = "Intensité de l'effet de bloom du trou blanc",
    ["white_hole_bloom_intensity_desc"] = "Intensité de la lueur des trous blancs.",
    ["invert_white_holes"] = "Inverser la masse des Trous Blancs",
    ["invert_white_holes_desc"] = "Utiliser des valeurs de masse positives pour les trous blancs au lieu\nde négatives.",
    ["gravitational_lensing_effect_scale"] = "Échelle de l'effet de lentille gravitationnelle",
    ["gravitational_lensing_effect_scale_desc"] = "Appliquer un facteur d'échelle à l'effet de lentille\ngravitationnelle.\nÉquivalent à changer la vitesse de la lumière simulée.",
    ["can_only_benchmark_while_in_game"] = "Peut seulement exécuter un benchmark en jeu.",
    ["right_click_to_reset"] = "Cliquez avec le bouton droit sur un paramètre pour le rétablir par défaut.",
    ["high_score"] = "Meilleur score",
    ["score"] = "Score",
    ["recompile_warning"] = "Les modifications nécessiteront une recompilation des shaders au prochain redémarrage (environ 1 minute).",
    ["hard_cap"] = "Limite de Trous Noirs dans le Shader",
    ["hard_cap_desc"] = "Compilez le shader pour supporter un nombre différent de\nTrous Noirs max.\nDes valeurs plus petites améliorent les performances.\nDes valeurs très élevées peuvent bloquer ou faire planter les\nGPU bas de gamme, et la compilation prendra quelques minutes\nlors du prochain redémarrage.",
  },
  ["Italiano"] = {
    ["title"] = "Buchi Neri con Ray Tracing",
    ["on"] = "Acceso",
    ["off"] = "Spento",
    ["performance_settings"] = "Impostazioni di Prestazioni",
    ["performance_settings_desc"] = "Impostazioni che influenzano le prestazioni.",
    ["run_benchmark"] = "Esegui Benchmark",
    ["run_benchmark_desc"] = "Esegui un breve benchmark per determinare le migliori impostazioni per il tuo sistema.",
    ["max_holes"] = "Numero massimo di Buchi Neri",
    ["max_holes_desc"] = "Numero massimo di buchi neri e bianchi.",
    ["accretion_disks"] = "Dischi di Accrescimento",
    ["accretion_disks_desc"] = "Abilita Dischi di Accrescimento",
    ["max_accretion_disks"] = "Numero massimo di Dischi di Accrescimento",
    ["max_accretion_disks_desc"] = "Numero massimo di dischi di accrescimento.",
    ["accretion_disks_on_small_black_holes"] = "Dischi di Accrescimento su piccoli buchi neri",
    ["accretion_disks_on_small_black_holes_desc"] = "Abilita Dischi di Accrescimento su piccoli buchi neri. \nPotrebbe ingombrare lo schermo.",
    ["advanced_settings"] = "Impostazioni Avanzate",
    ["advanced_settings_desc"] = "Impostazioni avanzate.",
    ["max_raymarching_steps"] = "Passi massimi di raymarching",
    ["max_raymarching_steps_desc"] = "Numero massimo di passi di raymarching per pixel.\n16-24 sono sufficienti.",
    ["other_visual_settings"] = "Altre Impostazioni Visive",
    ["other_visual_settings_desc"] = "Altre impostazioni visive che non influenzano le prestazioni.",
    ["accretion_disc_bloom_intensity"] = "Intensità dell'effetto bloom dei Dischi di Accrescimento",
    ["accretion_disc_bloom_intensity_desc"] = "Quanto luminosi saranno i Dischi\ndi Accrescimento.",
    ["disk_effect_opacity"] = "Opacità dell'effetto del Disco di Accrescimento",
    ["disk_effect_opacity_desc"] = "Applica trasparenza ai Dischi di Accrescimento.",
    ["white_hole_bloom_intensity"] = "Intensità dell'effetto bloom dei Buchi Bianchi",
    ["white_hole_bloom_intensity_desc"] = "Quanto luminosi saranno i Buchi Bianchi.",
    ["invert_white_holes"] = "Inverti la massa dei Bianchi",
    ["invert_white_holes_desc"] = "Usa valori di massa positivi per i buchi bianchi invece di negativi.",
    ["gravitational_lensing_effect_scale"] = "Scala dell'effetto di lente gravitazionale",
    ["gravitational_lensing_effect_scale_desc"] = "Applica un fattore di scala all'effetto di lente gravitazionale.\nEquivalente a cambiare la velocità della luce simulata.",
    ["can_only_benchmark_while_in_game"] = "Puoi eseguire il benchmark solo durante il gioco.",
    ["right_click_to_reset"] = "Fai clic con il pulsante destro per ripristinare l'impostazione predefinita.",
    ["high_score"] = "Punteggio Alto",
    ["score"] = "Punteggio",
    ["recompile_warning"] = "Le modifiche richiederanno la ricompilazione degli shader al prossimo riavvio (circa 1 minuto).",
    ["hard_cap"] = "Limite di Buchi Neri nello Shader",
    ["hard_cap_desc"] = "Compila lo shader per supportare un numero diverso di Buchi\nNeri massimi.\nValori più bassi migliorano le prestazioni.\nValori molto alti possono bloccare o far crashare le GPU\ndi fascia bassa e la compilazione richiederà alcuni minuti\nal prossimo riavvio.",
  },
  ["Polska"] = {
    ["title"] = "Czarne Dziury z Ray Tracing",
    ["on"] = "Włączone",
    ["off"] = "Wyłączone",
    ["performance_settings"] = "Ustawienia wydajności",
    ["performance_settings_desc"] = "Ustawienia wpływające na wydajność.",
    ["run_benchmark"] = "Uruchom benchmark",
    ["run_benchmark_desc"] = "Uruchom krótki benchmark, aby określić najlepsze ustawienia dla twojego systemu.",
    ["max_holes"] = "Maksymalna liczba czarnych dziur",
    ["max_holes_desc"] = "Maksymalna liczba czarnych i białych dziur.",
    ["accretion_disks"] = "Dyski akrecyjne",
    ["accretion_disks_desc"] = "Włącz dyski akrecyjne.",
    ["max_accretion_disks"] = "Maksymalna liczba dysków akrecyjnych",
    ["max_accretion_disks_desc"] = "Maksymalna liczba dysków akrecyjnych.",
    ["accretion_disks_on_small_black_holes"] = "Dyski akrecyjne na małych czarnych dziurach",
    ["accretion_disks_on_small_black_holes_desc"] = "Włącz dyski akrecyjne na małych czarnych dziurach.\nMoże zaśmiecać ekran.",
    ["advanced_settings"] = "Zaawansowane ustawienia",
    ["advanced_settings_desc"] = "Dostosuj ustawienia.",
    ["max_raymarching_steps"] = "Maksymalna liczba kroków raymarchingu",
    ["max_raymarching_steps_desc"] = "Maksymalna liczba kroków raymarchingu na piksel.\n16-24 będzie wystarczające.",
    ["other_visual_settings"] = "Inne ustawienia wizualne",
    ["other_visual_settings_desc"] = "Inne ustawienia wizualne, które nie wpływają na wydajność.",
    ["accretion_disc_bloom_intensity"] = "Intensywność blasku dysków akrecyjnych",
    ["accretion_disc_bloom_intensity_desc"] = "Jasność blasku dysków akrecyjnych.",
    ["disk_effect_opacity"] = "Przezroczystość efektu dysku akrecyjnego",
    ["disk_effect_opacity_desc"] = "Zastosuj przezroczystość do dysków akrecyjnych.",
    ["white_hole_bloom_intensity"] = "Intensywność blasku białych dziur",
    ["white_hole_bloom_intensity_desc"] = "Jasność blasku białych dziur.",
    ["invert_white_holes"] = "Odwróć masę Białych Dziur",
    ["invert_white_holes_desc"] = "Użyj dodatnich wartości masy dla białych dziur zamiast ujemnych.",
    ["gravitational_lensing_effect_scale"] = "Skala efektu soczewkowania grawitacyjnego",
    ["gravitational_lensing_effect_scale_desc"] = "Zastosuj współczynnik skali do efektu soczewkowania\ngrawitacyjnego.\nRównoważne zmianie symulowanej prędkości światła.",
    ["can_only_benchmark_while_in_game"] = "Benchmark można uruchomić tylko podczas gry.",
    ["right_click_to_reset"] = "Kliknij prawym przyciskiem myszy, aby przywrócić ustawienie do domyślnego.",
    ["high_score"] = "Najwyższy wynik",
    ["score"] = "Wynik",
    ["recompile_warning"] = "Zmiany będą wymagały ponownej kompilacji shaderów przy następnym uruchomieniu (około 1 minuty).",
    ["hard_cap"] = "Limit Czarnych Dziur w Shaderze",
    ["hard_cap_desc"] = "Skompiluj shader, aby obsługiwał inną maksymalną liczbę\nCzarnych Dziur.\nMniejsze wartości poprawiają wydajność.\nBardzo wysokie wartości mogą zawiesić lub spowodować awarię\nna słabszych GPU, a kompilacja zajmie kilka minut przy\nnastępnym uruchomieniu.",
  },
  ["简体中文"] = {
    ["title"] = "光线追踪黑洞",
    ["on"] = "开启",
    ["off"] = "关闭",
    ["performance_settings"] = "性能设置",
    ["performance_settings_desc"] = "影响性能的设置。",
    ["run_benchmark"] = "运行基准测试",
    ["run_benchmark_desc"] = "运行简短的基准测试，以确定适合您系统的最佳设置。",
    ["max_holes"] = "最大黑洞数量",
    ["max_holes_desc"] = "最大黑洞和白洞数量。",
    ["accretion_disks"] = "吸积盘",
    ["accretion_disks_desc"] = "启用吸积盘",
    ["max_accretion_disks"] = "最大吸积盘数量",
    ["max_accretion_disks_desc"] = "最大吸积盘数量。",
    ["accretion_disks_on_small_black_holes"] = "小黑洞上的吸积盘",
    ["accretion_disks_on_small_black_holes_desc"] = "在小黑洞上启用吸积盘。\n可能会使屏幕混乱。",
    ["advanced_settings"] = "高级设置",
    ["advanced_settings_desc"] = "微调设置。",
    ["max_raymarching_steps"] = "最大光线行进步数",
    ["max_raymarching_steps_desc"] = "每像素最大光线行进步数。\n16-24 就足够了。",
    ["other_visual_settings"] = "其他视觉设置",
    ["other_visual_settings_desc"] = "不影响性能的其他视觉设置。",
    ["accretion_disc_bloom_intensity"] = "吸积盘辉光强度",
    ["accretion_disc_bloom_intensity_desc"] = "吸积盘发光的亮度。",
    ["disk_effect_opacity"] = "吸积盘效果不透明度",
    ["disk_effect_opacity_desc"] = "为吸积盘应用透明度。",
    ["white_hole_bloom_intensity"] = "白洞辉光强度",
    ["white_hole_bloom_intensity_desc"] = "白洞发光的亮度。",
    ["invert_white_holes"] = "反转白洞质量",
    ["invert_white_holes_desc"] = "将白洞的负质量值改为正值。",
    ["gravitational_lensing_effect_scale"] = "引力透镜效应缩放",
    ["gravitational_lensing_effect_scale_desc"] = "应用引力透镜效应的缩放因子。\n相当于改变模拟的光速。",
    ["can_only_benchmark_while_in_game"] = "只能在游戏中进行基准测试。",
    ["right_click_to_reset"] = "右键单击设置以恢复默认值。",
    ["high_score"] = "最高分",
    ["score"] = "得分",
    ["recompile_warning"] = "更改将在下次重启时需要重新编译着色器（大约1分钟）。",
    ["hard_cap"] = "着色器黑洞限制",
    ["hard_cap_desc"] = "编译着色器以支持不同数量的最大黑洞。\n较小的值提高性能。\n非常高的值会使低端GPU挂起或崩溃，并且在下次重启时需要几分钟来编译。",
  },
  ["日本語"] = {
    ["title"] = "レイトレースされたブラックホール",
    ["on"] = "オン",
    ["off"] = "オフ",
    ["performance_settings"] = "パフォーマンス設定",
    ["performance_settings_desc"] = "パフォーマンスに影響を与える設定です。",
    ["run_benchmark"] = "ベンチマークを実行",
    ["run_benchmark_desc"] = "最適な設定を決定するために短いベンチマークを実行します。",
    ["max_holes"] = "最大ブラックホール数",
    ["max_holes_desc"] = "ブラックホールとホワイトホールの最大数。",
    ["accretion_disks"] = "降着円盤",
    ["accretion_disks_desc"] = "降着円盤を有効にする",
    ["max_accretion_disks"] = "最大降着円盤数",
    ["max_accretion_disks_desc"] = "降着円盤の最大数。",
    ["accretion_disks_on_small_black_holes"] = "小さなブラックホールの降着円盤",
    ["accretion_disks_on_small_black_holes_desc"] = "小さなブラックホールの降着円盤を有効にします。\n画面が乱雑になる可能性があります。",
    ["advanced_settings"] = "高度な設定",
    ["advanced_settings_desc"] = "設定を微調整します。",
    ["max_raymarching_steps"] = "最大レイマーチングステップ数",
    ["max_raymarching_steps_desc"] = "1ピクセルあたりの最大レイマーチングステップ数。\n16-24で十分です。",
    ["other_visual_settings"] = "その他の視覚設定",
    ["other_visual_settings_desc"] = "パフォーマンスに影響しないその他の視覚設定。",
    ["accretion_disc_bloom_intensity"] = "降着円盤のブルーム強度",
    ["accretion_disc_bloom_intensity_desc"] = "降着円盤の輝きの強さ。",
    ["disk_effect_opacity"] = "降着円盤効果の不透明度",
    ["disk_effect_opacity_desc"] = "降着円盤に透明度を適用します。",
    ["white_hole_bloom_intensity"] = "ホワイトホールのブルーム強度",
    ["white_hole_bloom_intensity_desc"] = "ホワイトホールの輝きの強さ。",
    ["invert_white_holes"] = "ホワイトホールの質量を反転",
    ["invert_white_holes_desc"] = "ホワイトホールに負の質量の代わりに正の質量を使用します。",
    ["gravitational_lensing_effect_scale"] = "重力レンズ効果のスケール",
    ["gravitational_lensing_effect_scale_desc"] = "重力レンズ効果にスケーリング係数を適用します。\n光の速度をシミュレートするのと同等です。",
    ["can_only_benchmark_while_in_game"] = "ゲーム中にのみベンチマークを実行できます。",
    ["right_click_to_reset"] = "設定を右クリックしてデフォルトに戻します。",
    ["high_score"] = "ハイスコア",
    ["score"] = "スコア",
    ["recompile_warning"] = "変更は次回の再起動時にシェーダーの再コンパイルが必要になります（約1分）。",
    ["hard_cap"] = "シェーダーのブラックホール制限",
    ["hard_cap_desc"] = "シェーダーをコンパイルして、最大ブラックホール数を変更します。\n小さい値はパフォーマンスを向上させます。\n非常に高い値は、低スペックのGPUでフリーズやクラッシュ\nを引き起こす可能性があり、次回の再起動時にコンパイルに\n数分かかります。",
  },
  ["한국어"] = {
    ["title"] = "레이 트레이싱 블랙홀",
    ["on"] = "켜짐",
    ["off"] = "꺼짐",
    ["performance_settings"] = "성능 설정",
    ["performance_settings_desc"] = "성능에 영향을 미치는 설정입니다.",
    ["run_benchmark"] = "벤치마크 실행",
    ["run_benchmark_desc"] = "시스템에 가장 적합한 설정을 결정하기 위해 짧은 벤치마크를 실행합니다.",
    ["max_holes"] = "최대 블랙홀 수",
    ["max_holes_desc"] = "블랙홀과 화이트홀의 최대 수.",
    ["accretion_disks"] = "강착 원반",
    ["accretion_disks_desc"] = "강착 원반을 활성화합니다.",
    ["max_accretion_disks"] = "최대 강착 원반 수",
    ["max_accretion_disks_desc"] = "강착 원반의 최대 수.",
    ["accretion_disks_on_small_black_holes"] = "작은 블랙홀에 강착 원반 표시",
    ["accretion_disks_on_small_black_holes_desc"] = "작은 블랙홀에 강착 원반을 활성화합니다. \n화면이 복잡해질 수 있습니다.",
    ["advanced_settings"] = "고급 설정",
    ["advanced_settings_desc"] = "설정을 세부 조정합니다.",
    ["max_raymarching_steps"] = "최대 레이마칭 단계",
    ["max_raymarching_steps_desc"] = "픽셀당 최대 레이마칭 단계를 설정합니다.\n16-24가 적당합니다.",
    ["other_visual_settings"] = "기타 시각적 설정",
    ["other_visual_settings_desc"] = "성능에 영향을 미치지 않는 기타 시각적 설정입니다.",
    ["accretion_disc_bloom_intensity"] = "강착 원반 빛번짐 강도",
    ["accretion_disc_bloom_intensity_desc"] = "강착 원반의 빛번짐 강도를 설정합니다.",
    ["disk_effect_opacity"] = "강착 원반 효과 불투명도",
    ["disk_effect_opacity_desc"] = "강착 원반에 투명도를 적용합니다.",
    ["white_hole_bloom_intensity"] = "화이트 홀 빛번짐 강도",
    ["white_hole_bloom_intensity_desc"] = "화이트 홀의 빛번짐 강도를 설정합니다.",
    ["invert_white_holes"] = "화이트 홀 질량 반전",
    ["invert_white_holes_desc"] = "화이트 홀에 음수 대신 양의 질량 값을 사용합니다.",
    ["gravitational_lensing_effect_scale"] = "중력 렌즈 효과 규모",
    ["gravitational_lensing_effect_scale_desc"] = "중력 렌즈 효과에 스케일링 요소를 적용합니다.\n빛의 속도를 시뮬레이션하여 변경하는 것과 동일합니다.",
    ["can_only_benchmark_while_in_game"] = "게임 중일 때만 벤치마크를 실행할 수 있습니다.",
    ["right_click_to_reset"] = "설정을 오른쪽 클릭하여 기본값으로 복원합니다.",
    ["high_score"] = "최고 점수",
    ["score"] = "점수",
    ["recompile_warning"] = "변경 사항은 다음 재시작 시 셰이더를 다시 컴파일해야 합니다 (약 1분).",
    ["hard_cap"] = "셰이더 블랙홀 한도",
    ["hard_cap_desc"] = "최대 블랙홀 수를 다르게 지원하도록 셰이더를 컴파일합니다.\n값이 작을수록 성능이 향상됩니다.\n매우 높은 값은 저사양 GPU에서 멈추거나 충돌할 수 있으며, 다음 재시작 시 컴파일에 몇\n분이 걸릴 수 있습니다.",
  },
  ["Suomi"] = {
    ["title"] = "Säteenseuratut Mustat Aukot",
    ["on"] = "Päällä",
    ["off"] = "Pois päältä",
    ["performance_settings"] = "Suorituskykyasetukset",
    ["performance_settings_desc"] = "Asetukset, jotka vaikuttavat suorituskykyyn.",
    ["run_benchmark"] = "Suorita vertailutesti",
    ["run_benchmark_desc"] = "Suorita lyhyt vertailutesti löytääksesi parhaat asetukset järjestelmällesi.",
    ["max_holes"] = "Maksimi mustien aukkojen määrä",
    ["max_holes_desc"] = "Maksimi mustien ja valkoisten aukkojen määrä.",
    ["accretion_disks"] = "Kertymälevyt",
    ["accretion_disks_desc"] = "Ota kertymälevyt käyttöön.",
    ["max_accretion_disks"] = "Maksimi kertymälevyjen määrä",
    ["max_accretion_disks_desc"] = "Maksimi kertymälevyjen määrä.",
    ["accretion_disks_on_small_black_holes"] = "Kertymälevyt pienillä mustilla aukoilla",
    ["accretion_disks_on_small_black_holes_desc"] = "Ota kertymälevyt käyttöön pienillä mustilla aukoilla. \nVoi tehdä näytöstä sekavan.",
    ["advanced_settings"] = "Lisäasetukset",
    ["advanced_settings_desc"] = "Hienosäädä asetuksia.",
    ["max_raymarching_steps"] = "Maksimi raymarching-vaiheet",
    ["max_raymarching_steps_desc"] = "Suurin määrä raymarching-vaiheita per pikseli.\n16-24 on riittävä.",
    ["other_visual_settings"] = "Muut visuaaliset asetukset",
    ["other_visual_settings_desc"] = "Muut visuaaliset asetukset, jotka eivät vaikuta suorituskykyyn.",
    ["accretion_disc_bloom_intensity"] = "Kertymälevyn hehkun voimakkuus",
    ["accretion_disc_bloom_intensity_desc"] = "Kuinka kirkkaasti kertymälevyt hehkuvat.",
    ["disk_effect_opacity"] = "Kertymälevyn vaikutuksen läpinäkyvyys",
    ["disk_effect_opacity_desc"] = "Sovella läpinäkyvyyttä kertymälevyihin.",
    ["white_hole_bloom_intensity"] = "Valkoisen aukon hehkun voimakkuus",
    ["white_hole_bloom_intensity_desc"] = "Kuinka kirkkaasti valkoiset aukot hehkuvat.",
    ["invert_white_holes"] = "Käännä valkoisten aukkojen massa",
    ["invert_white_holes_desc"] = "Käytä valkoisille aukoille positiivisia massaarvoja negatiivisten sijaan.",
    ["gravitational_lensing_effect_scale"] = "Gravitaatiolinssin vaikutuksen skaala",
    ["gravitational_lensing_effect_scale_desc"] = "Sovella skaalauskerrointa gravitaatiolinssin vaikutukseen.\nVastaa valon nopeuden simuloitua muutosta.",
    ["can_only_benchmark_while_in_game"] = "Vertailutestin voi suorittaa vain pelissä.",
    ["right_click_to_reset"] = "Palauta oletusasetukset napsauttamalla oikealla painikkeella.",
    ["high_score"] = "Ennätyspisteet",
    ["score"] = "Pisteet",
    ["recompile_warning"] = "Muutokset vaativat shaderin uudelleenkääntämisen seuraavassa käynnistyksessä (noin 1 minuutti).",
    ["hard_cap"] = "Shaderin mustan aukon raja",
    ["hard_cap_desc"] = "Käännä shader tukemaan erilaista maksimimäärää mustia aukkoja.\nPienemmät arvot parantavat suorituskykyä.\nHyvin korkeat arvot voivat jumittaa tai kaataa heikkotehoiset\nnäytönohjaimet, ja kääntäminen kestää muutaman minuutin seuraavalla\nkäynnistyksellä.",
  }
}

local currentLang = GameTextGetTranslatedOrNot("$current_language")
local L = translations[currentLang] or translations.english

BenchmarkStep = 0
BenchmarkClicks = 0
GlobalFrame = 0
LastClick = -30

function set_accretion_disk_settings_visibility(value)
  local accretion_disk_settings = {
    "max_accretion_disks",
    "accretion_disks_on_small_black_holes_enabled",
		"accretion_disc_bloom_intensity",
		"disk_effect_opacity",
  }

  for _, child in ipairs(mod_settings) do
    if child.settings then
      for _, setting in ipairs(child.settings) do
        for _, id in ipairs(accretion_disk_settings) do
          if setting.id == id then
            setting.hidden = not value
          end
        end
      end
    end
  end
end

function check_uniforms(setting, new_value, in_main_menu)
  if setting.uniform_name ~= nil and not in_main_menu then
    set_uniform(setting.uniform_name, new_value)
  end
end

function set_uniform(name, value)
  if type(value) == "boolean" then
    value = value and 1.0 or 0.0
  end
  GameSetPostFxParameter(name, value, 0.0, 0.0, 0.0)
end

function mod_setting_change_callback_performance( mod_id, gui, in_main_menu, setting, old_value, new_value  )
  GameSetPostFxParameter("RBH_live_editing", 1.0, 0.0, 0.0, 0.0)
  check_uniforms(setting, new_value, in_main_menu)
end

function mod_setting_change_callback_visual( mod_id, gui, in_main_menu, setting, old_value, new_value  )
  GameSetPostFxParameter("RBH_live_editing", 1.0, 0.0, 0.0, 0.0)
  check_uniforms(setting, new_value, in_main_menu)
end

-- Return an x/y offset based on the current global frame and the last click frame
function wiggle()
  return math.sin( math.min(GlobalFrame - (LastClick + 30), 0)  * 0.1 * BenchmarkClicks)
end

function text_title( mod_id, gui, in_main_menu, im_id, setting)
  local s = 0.25
  local v = 1
  local h = (GlobalFrame % 360) / 360

  local r, g, b

  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  GuiColorSetForNextWidget( gui, r, g, b, 1 )

  GuiText( gui, im_id, 0, setting.ui_name )
	GuiLayoutAddVerticalSpacing( gui, 4 )
end

function text_hint( mod_id, gui, in_main_menu, im_id, setting)
  GuiColorSetForNextWidget( gui, 0.5, 0.5, 0.5, 1 )
  GuiText( gui, im_id, 0, setting.ui_name )
end

function benchmark_button( mod_id, gui, in_main_menu, im_id, setting)
  if in_main_menu then
    local text = setting.ui_name .. " - " .. L["can_only_benchmark_while_in_game"]
    GuiColorSetForNextWidget( gui, 0.35, 0.35, 0.35, 1 )
    if GuiButton( gui, im_id, mod_setting_group_x_offset + wiggle(), 0, text ) then
      LastClick = GlobalFrame
      BenchmarkClicks = BenchmarkClicks + 1
      if BenchmarkClicks == 4 then
        if Worm == nil then resetWorm() else Worm = nil end
        BenchmarkClicks = 3
      end
    end
  else
    local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
    local text = setting.ui_name .. ": " .. GameTextGet( value and "$option_on" or "$option_off" )
    if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
      ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
    end
  end
end

-- This isnt updating in realtime
function max_black_holes_slider( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "number" then value = setting.value_default or 0.0 end

	local value_new = GuiSlider( gui, im_id, mod_setting_group_x_offset, 0, setting.ui_name, value, setting.value_min, setting.value_max, setting.value_default, setting.value_display_multiplier or 1, setting.value_display_formatting or "", 64 )
	if value ~= value_new then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value_new, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, value_new )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

-- Create a custom button just to update the accretion disk settings visibility on first load
  -- This is running every frame but it's not a big deal
function accretion_disks_enabled_button( mod_id, gui, in_main_menu, im_id, setting)
  local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )

  set_accretion_disk_settings_visibility(value)

  local text = setting.ui_name .. ": " .. GameTextGet( value and "$option_on" or "$option_off" )

  if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
    ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
  end

  mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
  check_uniforms(setting, value, in_main_menu)
end

Max_on_load = ModSettingGet("raytraced_black_holes.hard_cap") or 16

local function render_settings()
  local mod_settings =
  {
    {
      id = "title",
      ui_name = L["title"],
      not_setting = true,
      ui_fn = text_title,
    },
    {
      category_id = "performance_settings",
      ui_name = L["performance_settings"],
      ui_description = L["performance_settings_desc"],
      settings = {
        {
          id = "run_benchmark",
          ui_name = L["run_benchmark"],
          ui_description = L["run_benchmark_desc"],
          scope = MOD_SETTING_SCOPE_RUNTIME,
          ui_fn = benchmark_button,
        },
        {
          id = "max_holes",
          ui_name = L["max_holes"],
          ui_description = L["max_holes_desc"],
          value_default = 16,
          value_min = 1,
          value_max = Max_on_load,
          value_display_multiplier = 1,
          value_display_formatting = " $0",
          scope = MOD_SETTING_SCOPE_RUNTIME,
          ui_fn = max_black_holes_slider,
          change_fn = mod_setting_change_callback_performance,
          uniform_name = "RBH_max",
        },
        -- {
        --   id = "min_framerate",
        --   ui_name = L["min_framerate"],
        --   ui_description = L["min_framerate_desc"],
        --   value_default = 60,
        --   value_min = 1,
        --   value_max = 60,
        --   value_display_multiplier = 1,
        --   value_display_formatting = " $0",
        --   scope = MOD_SETTING_SCOPE_RUNTIME,
        -- },
        {
          id = "accretion_discs_enabled",
          ui_name = L["accretion_disks"],
          ui_description = L["accretion_disks_desc"],
          value_default = true,
          scope = MOD_SETTING_SCOPE_RUNTIME,
          ui_fn = accretion_disks_enabled_button,
          change_fn = mod_setting_change_callback_performance,
          uniform_name = "RBH_discs_enabled",
        },
        -- {
        --   id = "max_accretion_disks",
        --   ui_name = L["max_accretion_disks"],
        --   ui_description = L["max_accretion_disks_desc"],
        --   value_default = 32,
        --   value_min = 1,
        --   value_max = 100,
        --   value_display_multiplier = 1,
        --   value_display_formatting = " $0",
        --   scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
        -- },
        {
          id = "accretion_disks_on_small_black_holes_enabled",
          ui_name = L["accretion_disks_on_small_black_holes"],
          ui_description = L["accretion_disks_on_small_black_holes_desc"],
          value_default = false,
          hidden = true,
          indent = 20,
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_performance,
          uniform_name = "RBH_small_discs",
        },
        {
          category_id = "advanced_settings",
          ui_name = L["advanced_settings"],
          ui_description = L["advanced_settings_desc"],
          foldable = true,
          _folded = true, -- this field will be automatically added to each gategory table to store the current folding state
          settings = {
            {
              id = "raymarching_steps",
              ui_name = L["max_raymarching_steps"],
              ui_description = L["max_raymarching_steps_desc"],
              value_default = 16,
              value_min = 1,
              value_max = 32,
              value_display_multiplier = 1,
              value_display_formatting = " $0",
              scope = MOD_SETTING_SCOPE_RUNTIME,
              change_fn = mod_setting_change_callback_performance,
              uniform_name = "RBH_steps",
            },
            {
              id = "hard_cap",
              ui_name = L["hard_cap"],
              ui_description = L["hard_cap_desc"],
              value_default = 16,
              value_min = 1,
              value_max = 100,
              value_display_multiplier = 1,
              value_display_formatting = " $0",
              scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
            },
          },
        },
      },
    },
    {
      category_id = "visual_settings",
      ui_name = L["other_visual_settings"],
      ui_description = L["other_visual_settings_desc"],
      settings = {
        {
          id = "accretion_disc_bloom_intensity",
          ui_name = L["accretion_disc_bloom_intensity"],
          ui_description = L["accretion_disc_bloom_intensity_desc"],
          value_default = 1,
          hidden = true,
          value_min = 0,
          value_max = 2,
          value_display_multiplier = 100,
          value_display_formatting = " $0%",
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_visual,
          uniform_name = "RBH_disc_bloom_intensity",
        },
        {
          id = "disk_effect_opacity",
          ui_name = L["disk_effect_opacity"],
          ui_description = L["disk_effect_opacity_desc"],
          value_default = 1,
          hidden = true,
          value_min = 0,
          value_max = 1,
          value_display_multiplier = 100,
          value_display_formatting = " $0%",
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_visual,
          uniform_name = "RBH_disk_opacity",
        },
        {
          id = "white_hole_bloom_intensity",
          ui_name = L["white_hole_bloom_intensity"],
          ui_description = L["white_hole_bloom_intensity_desc"],
          value_default = 1,
          value_min = 0,
          value_max = 2,
          value_display_multiplier = 100,
          value_display_formatting = " $0%",
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_visual,
          uniform_name = "RBH_white_hole_bloom_intensity",
        },
        {
          id = "warp_scale",
          ui_name = L["gravitational_lensing_effect_scale"],
          ui_description = L["gravitational_lensing_effect_scale_desc"],
          value_default = 1,
          value_min = 0,
          value_max = 2,
          value_display_multiplier = 100,
          value_display_formatting = " $0%",
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_visual,
          uniform_name = "RBH_warp_scale",
        },
        {
          id = "invert_white_holes",
          ui_name = L["invert_white_holes"],
          ui_description = L["invert_white_holes_desc"],
          value_default = false,
          scope = MOD_SETTING_SCOPE_RUNTIME,
          change_fn = mod_setting_change_callback_visual,
          uniform_name = "RBH_invert_white_holes",
        },
      }
    },
    {
      id = "right_click_notice",
      ui_name = L["right_click_to_reset"],
      not_setting = true,
      ui_fn = text_hint,
    }
  }
  return mod_settings
end

local mod_id = "raytraced_black_holes" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings = render_settings()

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function resetWorm()
  Frame = -1
  Worm = {
    {x = 110, y = 90,  dir = 1},
    {x = 110, y = 100, dir = 1},
    {x = 110, y = 110, dir = 1},
    {x = 110, y = 120, dir = 1},
    {x = 110, y = 130, dir = 1},
  }
  FoodGrid = {}
  WormGrid = {}
  LastKey = -1
  CurSpriteId = 100000
  Score = 0
  GameOver = false
  HighScoreSet = false
  Falling = {}
  Exploded = false
end

function worm(gui)
  Frame = Frame + 1

  local hiScore = ModSettingGet("raytraced_black_holes.wormHiScore") or 0
  local gridScale = 10

  GuiLayoutBeginLayer( gui )
  GuiZSet( gui, 100 )
  GuiText(gui, 10, 10, L["high_score"] .. ":")
  GuiText(gui, 10, 20, L["score"] .. ":")
  GuiText(gui, 85, 10, tostring( math.max(hiScore, Score)))
  GuiText(gui, 85, 20, tostring(Score))

  if LastKey == -1 then
    GuiText(gui, 108, 60, "W")
    GuiText(gui, 98, 70, "A")
    GuiText(gui, 108, 70, "S")
    GuiText(gui, 118, 70, "D")
  end

  GuiLayoutEndLayer( gui )

  local ScreenBounds = {63, 35}
  local Foods = {"fish","slimeshooter","bat","duck","shotgunner","rat","scavenger_smg","frog","longleg","player"}

  local sprite = {
    head = { file = "data/enemies_gfx/worm_head.xml", size_x = 16, size_y = 13, offset_x = 5,  offset_y = 7, },
    body = { file = "data/enemies_gfx/worm_body.xml", size_x = 14, size_y = 12, offset_x = 15, offset_y = 6, },
    tail = { file = "data/enemies_gfx/worm_tail.xml", size_x = 14, size_y = 12, offset_x = 15, offset_y = 6, },
    fish = { file = "data/enemies_gfx/fish_01.xml",   size_x = 10, size_y = 10, offset_x = 5,  offset_y = 5, },
    slimeshooter = { file = "data/enemies_gfx/slimeshooter.xml", size_x = 16, size_y = 24, offset_x = 8,  offset_y = 20, },
    bat = { file = "data/enemies_gfx/bat.xml", size_x = 17, size_y = 17, offset_x = 8,  offset_y = 12, },
    duck = { file = "data/enemies_gfx/duck.xml", size_x = 13, size_y = 13, offset_x = 6,  offset_y = 9, },
    shotgunner = { file = "data/enemies_gfx/shotgunner.xml", size_x = 17, size_y = 17, offset_x = 8,  offset_y = 7.5, },
    rat = { file = "data/enemies_gfx/rat.xml", size_x = 20, size_y = 20, offset_x = 20,  offset_y = 10, },
    scavenger_smg = { file = "data/enemies_gfx/scavenger_smg.xml", size_x = 20, size_y = 21, offset_x = 10,  offset_y = 15, },
    frog = { file = "data/enemies_gfx/frog.xml", size_x = 20, size_y = 20, offset_x = 10,  offset_y = 10, },
    longleg = { file = "data/enemies_gfx/longleg.xml", size_x = 12, size_y = 8, offset_x = 6,  offset_y = 0, },
    player = { file = "data/enemies_gfx/player.xml", size_x = 19, size_y = 12, offset_x = 10,  offset_y = 11, },
    explode = { file = "data/particles/explosion_meteor.xml", size_x = 40, size_y = 40, offset_x = 20,  offset_y = 20, },
  }

  local function get_sprite_id()
    CurSpriteId = CurSpriteId + 1
    return CurSpriteId
  end

  local function rotate_coords(x, y, rotation, size_x, size_y, offset_x, offset_y)
    local visual_center_x = size_x / 2
    local visual_center_y = size_y / 2

    local offset_x = visual_center_x - offset_x
    local offset_y = visual_center_y - offset_y

    -- Translate to origin, rotate, then translate back
    local cos_rot = math.cos(rotation)
    local sin_rot = math.sin(rotation)

    local rotated_offset_x = offset_x * cos_rot - offset_y * sin_rot
    local rotated_offset_y = offset_x * sin_rot + offset_y * cos_rot

    local final_x = x - rotated_offset_x
    local final_y = y - rotated_offset_y

    return final_x, final_y
  end

  local function draw_sprite(x, y, rotation, name, id, noloop)
    local sprite = sprite[name]
    local animation = noloop and GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndHide or GUI_RECT_ANIMATION_PLAYBACK.Loop
    x, y = rotate_coords(x, y, rotation, sprite.size_x, sprite.size_y, sprite.offset_x, sprite.offset_y)
    GuiImage( gui, id, x , y , sprite.file, 1, 1, 1, rotation, animation )
  end


  local function spawn_food(radius)
    -- First, loop through all worm and food segments and store their x * y position in a table which we can then look up later
    local occupied_positions = {}
    for pos, segment in pairs(WormGrid) do
      occupied_positions[pos] = true
    end
    for pos, food in pairs(FoodGrid) do
      occupied_positions[pos] = true
    end

    -- Now, go through all possible grid positions and add them to the free positions table if they are not occupied
    local free_positions = {}
    for x = 1, ScreenBounds[1] do
      for y = 1, ScreenBounds[2] do
        local scale_x, scale_y = x * gridScale, y * gridScale
        if occupied_positions[scale_x .. "." .. scale_y] == nil then
          -- Check if we should spawn food in a circle around the worm tail
          if radius ~= nil then
            local scale_radius = radius * gridScale
            local dx = scale_x - Worm[#Worm].x
            local dy = scale_y - Worm[#Worm].y
            if dx * dx + dy * dy <= scale_radius * scale_radius then
              table.insert(free_positions, {x = scale_x, y = scale_y})
            end
          else
            table.insert(free_positions, {x = scale_x, y = scale_y})
          end
        end
      end
    end

    -- If there are free positions, pick one at random and add food there
    if #free_positions > 0 then
      local pos = free_positions[math.random(1, #free_positions)]
      local food_name = Foods[math.random(1, #Foods)]
      local hash = pos.x .. "." .. pos.y
      FoodGrid[hash] = {name = food_name, x = pos.x, y = pos.y, id = get_sprite_id()}
    end
  end

  local function move_worm(dir)
    -- Add segment to the worm where the head used to be
    table.insert(Worm, 1, {x = Worm[1].x, y = Worm[1].y, dir = Worm[1].dir})
    Worm[1].dir = dir

    if dir == 0 then
      Worm[1].x = Worm[1].x - gridScale
    elseif dir == 1 then
      Worm[1].y = Worm[1].y - gridScale
    elseif dir == 2 then
      Worm[1].x = Worm[1].x + gridScale
    elseif dir == 3 then
      Worm[1].y = Worm[1].y + gridScale
    end

    local pos = Worm[1].x .. "." .. Worm[1].y

    -- Check if we hit ourselves
    if WormGrid[pos] ~= nil then
      GameOver = true
    end

    WormGrid[pos] = true

    -- Check if we are out of bounds
    if Worm[1].x < 1 or Worm[1].x > ScreenBounds[1] * gridScale or Worm[1].y < 1 or Worm[1].y > ScreenBounds[2] * gridScale then
      GameOver = true
    end

    -- Check if we ate food
    if FoodGrid[pos] ~= nil then
      FoodGrid[pos] = nil
      Score = Score + 100
      spawn_food(#Worm/2)
    else
      table.remove(Worm, #Worm)
      WormGrid[Worm[#Worm].x .. "." .. Worm[#Worm].y] = nil
    end
  end

  if InputIsKeyJustDown(73) then -- Insert
    for i = 1, 50 do
      table.insert(Worm, {x = 110, y = 110 + i * 10, dir = 1})
    end
  end

  -- Input
  if InputIsKeyJustDown(26) and Worm[1].dir ~= 3 then LastKey = 1 end -- w
  if InputIsKeyJustDown(4)  and Worm[1].dir ~= 2 then LastKey = 0 end -- a
  if InputIsKeyJustDown(22) and Worm[1].dir ~= 1 then LastKey = 3 end -- s
  if InputIsKeyJustDown(7)  and Worm[1].dir ~= 0 then LastKey = 2 end -- d


  GuiLayoutBeginLayer( gui )
  GuiZSet( gui, -100 )

  if GameOver then
    if not HighScoreSet and Score > hiScore then
      ModSettingSet("raytraced_black_holes.wormHiScore", Score)
      HighScoreSet = true
    end

    -- Set up the falling animation
    if Frame % 2 == 0 then
      if #Worm - #Falling > 1 then
        table.insert(Falling, {segment = Worm[#Worm - #Falling], vel_y = 0, vel_x = math.random(-100, 100) * 0.002})
      else
        Exploded = true
      end
    end

    -- Falling animation
    for i, piece in pairs(Falling) do
      local segment = piece.segment
      piece.vel_y = piece.vel_y + 0.2
      segment.y = segment.y + piece.vel_y

      if segment.y > ScreenBounds[2] * gridScale + gridScale / 2 then
        segment.y = ScreenBounds[2] * gridScale + gridScale / 2
        --table.remove(Falling, i)
      else
        segment.x = segment.x + piece.vel_x
        if segment.dir < math.pi/2 then
          segment.dir = segment.dir + 0.02
        elseif segment.dir < math.pi then
          segment.dir = segment.dir - 0.02
        end
      end
    end

  else
    -- Game loop ---------------------------------------
    -- Move worm
    local maxWormLengthForSpeedup = 100
    local minFrameInterval = 4
    local maxFrameInterval = 10
    local frameIntervalDecreasePerUnit = (maxFrameInterval - minFrameInterval) / maxWormLengthForSpeedup

    local currentFrameInterval = math.max(minFrameInterval, maxFrameInterval - #Worm * frameIntervalDecreasePerUnit)

    if Frame % math.floor(currentFrameInterval) == 0 then
      if LastKey ~= -1 then
        move_worm(LastKey)
      end
    end


    -- Spawn food
    local foodCount = 0
    local maxFoodCount = 6
    for i, food in pairs(FoodGrid) do
      foodCount = foodCount + 1
      if foodCount > maxFoodCount then break end
    end
    if foodCount < maxFoodCount then
      spawn_food()
    end
    ----------------------------------------------------
  end


  -- Draw food
  for i, food in pairs(FoodGrid) do
    local x = food.x
    local y = food.y
    draw_sprite(x, y, 0, food.name, food.id)
  end

  -- Draw worm
  for i, segment in ipairs(Worm) do
    local x = segment.x
    local y = segment.y
    local rotation = segment.dir * math.pi/2
    if i == 1 then
      GuiZSet( gui, -150 )
      if Exploded then
        draw_sprite(x, y, rotation, "explode", 10001, true)
      else
        draw_sprite(x, y, rotation, "head", 10000)
      end
      GuiZSet( gui, -100 )
    elseif i == #Worm then
      draw_sprite(x, y, rotation, "tail", 10002)
    else
      draw_sprite(x, y, rotation, "body", 10003)
    end
  end

  GuiLayoutEndLayer( gui )

end

function ModSettingsGui( gui, in_main_menu )
  local newLang = GameTextGetTranslatedOrNot("$current_language")
  if(newLang ~= currentLang) then
    currentLang = newLang
    L = translations[currentLang] or translations.english
    mod_settings = render_settings()
  end

	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )

  GlobalFrame = GlobalFrame + 1

  if Worm ~= nil then worm(gui) end
end
