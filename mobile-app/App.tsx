import React, { useEffect, useMemo, useState } from 'react';
import { StatusBar } from 'expo-status-bar';
import { NavigationContainer, DarkTheme as NavigationDarkTheme, DefaultTheme as NavigationDefaultTheme } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
// Stack is not used yet; keeping tabs simple for now
import { View, Text, useColorScheme, Pressable } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { MaterialIcons } from '@expo/vector-icons';

type RootTabParamList = {
  Home: undefined;
  Search: undefined;
  Settings: undefined;
};

const HomeScreen = () => {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text style={{ fontSize: 20, fontWeight: '600' }}>Bienvenue 👋</Text>
      <Text style={{ marginTop: 8, opacity: 0.7 }}>App de démarrage iOS & Android</Text>
    </View>
  );
};

const SearchScreen = () => {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text style={{ fontSize: 20, fontWeight: '600' }}>Recherche</Text>
      <Text style={{ marginTop: 8, opacity: 0.7 }}>Tapez pour chercher</Text>
    </View>
  );
};

type SettingsProps = {
  onToggleTheme: () => void;
  isDark: boolean;
};

const SettingsScreen = ({ onToggleTheme, isDark }: SettingsProps) => {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', padding: 24 }}>
      <Text style={{ fontSize: 20, fontWeight: '600', marginBottom: 12 }}>Paramètres</Text>
      <Pressable
        onPress={onToggleTheme}
        style={({ pressed }) => ({
          paddingHorizontal: 16,
          paddingVertical: 12,
          borderRadius: 10,
          backgroundColor: isDark ? '#2d2d2d' : '#e6e6e6',
          opacity: pressed ? 0.8 : 1,
        })}
      >
        <Text style={{ fontSize: 16 }}>{isDark ? 'Passer en mode clair' : 'Passer en mode sombre'}</Text>
      </Pressable>
      <Text style={{ marginTop: 12, opacity: 0.6 }}>Le choix est mémorisé.</Text>
    </View>
  );
};

const THEME_KEY = 'app_theme_preference';

const Tab = createBottomTabNavigator<RootTabParamList>();

export default function App() {
  const systemColorScheme = useColorScheme();
  const [isDark, setIsDark] = useState<boolean>(systemColorScheme === 'dark');
  const [isLoadingTheme, setIsLoadingTheme] = useState<boolean>(true);

  useEffect(() => {
    (async () => {
      try {
        const stored = await AsyncStorage.getItem(THEME_KEY);
        if (stored === 'dark' || stored === 'light') {
          setIsDark(stored === 'dark');
        } else {
          setIsDark(systemColorScheme === 'dark');
        }
      } catch {}
      setIsLoadingTheme(false);
    })();
  }, [systemColorScheme]);

  const toggleTheme = async () => {
    const next = !isDark;
    setIsDark(next);
    try {
      await AsyncStorage.setItem(THEME_KEY, next ? 'dark' : 'light');
    } catch {}
  };

  const navTheme = useMemo(() => (isDark ? NavigationDarkTheme : NavigationDefaultTheme), [isDark]);

  if (isLoadingTheme) {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
        <Text>Chargement…</Text>
      </View>
    );
  }

  return (
    <NavigationContainer theme={navTheme}>
      <StatusBar style={isDark ? 'light' : 'dark'} />
      <Tab.Navigator
        screenOptions={({ route }) => ({
          headerShown: true,
          tabBarIcon: ({ color, size }) => {
            const name = route.name === 'Home' ? 'home-filled' : route.name === 'Search' ? 'search' : 'settings';
            return <MaterialIcons name={name as any} size={size} color={color} />;
          },
        })}
      >
        <Tab.Screen name="Home" component={HomeScreen} options={{ title: 'Accueil' }} />
        <Tab.Screen name="Search" component={SearchScreen} options={{ title: 'Recherche' }} />
        <Tab.Screen name="Settings">
          {() => <SettingsScreen onToggleTheme={toggleTheme} isDark={isDark} />}
        </Tab.Screen>
      </Tab.Navigator>
    </NavigationContainer>
  );
}
