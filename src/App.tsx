import { ChurchIcon } from 'lucide-react';
import { TitheForm } from '@/components/TitheForm';
import { Toaster } from '@/components/ui/toaster';

function App() {
  return (
    <div className="min-h-screen bg-gray-50">
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-md mx-auto">
          <div className="mb-8 text-center">
            <div className="flex justify-center mb-4">
              <ChurchIcon className="h-12 w-12 text-primary" />
            </div>
            <h1 className="text-2xl font-bold text-gray-900 mb-2">
              Registro de Diezmos y Ofrendas
            </h1>
            <p className="text-gray-600">
              Registre sus contribuciones a la iglesia
            </p>
          </div>
          
          <div className="bg-white rounded-lg shadow-lg p-6">
            <TitheForm />
          </div>
        </div>
      </div>
      <Toaster />
    </div>
  );
}

export default App;